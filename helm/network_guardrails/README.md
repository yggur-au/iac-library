# network-guardrails

Cluster-wide Cilium network guardrails for the apps AKS cluster: **no in-cluster traffic between app namespaces** - app-to-app traffic has to go out through the shared Envoy Gateway by hostname, where it is subject to the Gateway's TLS and routing. Policy objects only (`CiliumClusterwideNetworkPolicy`, CCNP) - no pods, no chart dependencies, no images.

## Model

Two layers, both enforced by the Cilium dataplane:

1. **Per-app allows** - each app chart ships its own default-deny (ingress + egress) `NetworkPolicy` plus narrow allows (ingress from the Gateway, DNS, its data-plane ports).
2. **This chart - deny-only guardrails.** Cilium deny rules always win over allow rules from any policy, and allow rules are additive - so a guardrail made only of deny rules can never widen what a chart allows, and a chart can never allow its way past the guardrail. Every policy sets `enableDefaultDeny: {ingress: false, egress: false}`, so the guardrail on its own never puts a namespace into default-deny (without it, Cilium treats a deny-only section as a default-deny for that direction - a known outage pattern).

CCNPs are cluster-scoped, so nobody with only namespace-level rights can delete or edit them, and they can be created before the namespaces they name exist.

| Policy | Selects | Denies |
|---|---|---|
| `network-guardrails-baseline` | every namespace in `namespaces` plus `envoy-gateway-system` (or, with `catchAll.enabled`, every namespace not in `catchAll.excludeNamespaces`) | egress to Azure IMDS `169.254.169.254/32`, to the kubelet API (TCP 10250 on the `host`/`remote-node` entities), and to every kube-system pod except CoreDNS (`k8s-app: kube-dns`) |
| `network-guardrails-<namespace>` | pods in that app namespace | ingress from pods in any other namespace, and egress to pods in any other namespace, except: the Envoy proxy pods in `envoy-gateway-system` (`app.kubernetes.io/component: proxy` + `app.kubernetes.io/managed-by: envoy-gateway` - not the Envoy Gateway controller), CoreDNS (via the baseline), and the namespace's listed exceptions. Also egress to the `kube-apiserver` entity unless `allowKubeApiServer: true` |

`envoy-gateway-system` gets the baseline only - it is the path between namespaces, so its cross-namespace traffic is left to the Envoy chart's own policies.

Non-pod traffic is never touched by the cross-namespace rules: world (the internet, Azure PaaS, on-premises), Azure load balancer traffic, host-networked pods and the kube-apiserver (except the explicit `allowKubeApiServer` deny) are all left to the per-chart policies. The deny selectors pair `NotIn` with an `Exists` on the namespace label for exactly this reason - `NotIn` alone would also match those identities, which carry no namespace label.

### Why "via the Gateway" still works

AKS with Cilium has no kube-proxy - Cilium's socket-level load balancer translates Service addresses (ClusterIP and LoadBalancer IPs alike) to a backend pod at `connect()` time, before policy is evaluated. A pod calling `https://netbox.ae.yggur.com` resolves the Gateway's internal load balancer IP, which Cilium rewrites to an Envoy proxy pod, so policy sees egress to an `envoy-gateway-system` proxy pod (allowed), and the app then sees ingress from that proxy pod (allowed). Two consequences for the per-chart policies:

- A chart's own egress allow for the Gateway must target the proxy pods' **container** ports, not the listener ports - Envoy Gateway maps privileged listener ports +10000 (443 -> 10443, 80 -> 10080).
- The same translation means an in-cluster Service in another namespace is always seen as its backend pods - denied here - so there is no ClusterIP loophole.

## Exceptions

Set per namespace in `values.yaml` (`allowIngressFrom` / `allowEgressTo`, each entry `{namespace, podLabels}`; no `podLabels` = the whole namespace). At most one entry per namespace per direction - the template fails the render on a duplicate, because two label sets for the same namespace can't be expressed as deny rules.

| Namespace | Exception | Why |
|---|---|---|
| `cert-manager` | ingress from kube-system `app: konnectivity-agent` | kube-apiserver -> cert-manager webhook calls come through the AKS konnectivity tunnel (private cluster, no API Server VNet Integration). If the agent is host-networked they arrive as the `remote-node` entity instead, which this chart never denies |
| `cert-manager`, `external-dns` | `allowKubeApiServer: true` | controllers - watch/update Kubernetes objects |

Egress exceptions into kube-system are not supported - the baseline denies every non-CoreDNS kube-system pod for every guarded namespace.

## Adding a namespace

Add it under `namespaces` in `values.yaml` (`{}` if it needs nothing extra, `allowKubeApiServer: true` only if it runs a controller that talks to the Kubernetes API) and redeploy this chart - before or after the app itself. A namespace that isn't listed gets no guardrail of its own (listed namespaces still refuse its traffic), and only the baseline if `catchAll.enabled` is on.

## Verifying

- `kubectl get ccnp` - expect `network-guardrails-baseline` plus one `network-guardrails-<namespace>` per listed namespace.
- Test in a namespace with no NetworkPolicies of its own, so only the guardrail applies: temporarily list `guardrail-test` under `namespaces`, redeploy, then `kubectl create ns guardrail-test` and `kubectl -n guardrail-test run t --rm -it --image=<curl image from ACR> --restart=Never -- sh`:
  - `curl -m 5 http://<service>.netbox.svc.cluster.local:8080` - expected to **time out** (cross-namespace, in-cluster).
  - `curl -m 5 https://netbox.ae.yggur.com` - expected to **succeed** (via the Gateway; add `-k` while the Gateway presents its placeholder certificate).
  - `curl -m 5 -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2021-02-01"` - expected to **time out** (IMDS).
  - `nslookup netbox.ae.yggur.com` - expected to **succeed** (CoreDNS).
  - Remove `guardrail-test` from `namespaces` and delete the namespace afterwards.
- Denied traffic is dropped silently on AKS (no reject), so a blocked connection hangs until timeout rather than failing fast - always use `-m`/`--max-time`.

## Cilium on AKS - what this relies on and its limits

- **Supported without Advanced Container Networking Services (ACNS):** Kubernetes `NetworkPolicy`, L3/L4 `CiliumNetworkPolicy` and `CiliumClusterwideNetworkPolicy`. Deny rules (`ingressDeny`/`egressDeny`) are L3/L4 and have been on by default since Cilium 1.9.
- **Not available without ACNS:** FQDN (`toFQDNs`) and L7 (HTTP/gRPC/Kafka) policies, and flow logs/metrics (no Hubble to observe drops). Deny rules can't use L7 or FQDNs in any case.
- **Cilium version:** AKS ships at least Cilium 1.17.18 on Kubernetes 1.32/1.33 and 1.18.12 on 1.34/1.35. `enableDefaultDeny` is honoured on these; Cilium 1.16.6-1.16.x had a bug where a deny-only CCNP with `enableDefaultDeny.egress: false` still blocked all egress (cilium/cilium#37729) - do not run this chart on a cluster older than Kubernetes 1.32.
- **`ipBlock` / CIDR rules can't select pod or node IPs** on AKS - hence entities (`host`, `remote-node`, `kube-apiserver`) and pod selectors here, never node CIDRs.
- **Host-networked pods** use the host identity and are not subject to network policy.
- **kube-apiserver identity on AKS is unreliable** for traffic the API server sends into the cluster (it shows as `remote-node` - cilium/cilium#31711), which is why webhook ingress is never denied by entity. The `allowKubeApiServer` egress deny relies on Cilium recognising the API server's address from the `kubernetes` endpoints; if it doesn't, that one rule fails open (no effect) rather than breaking anything.
- Only label exclusion may be changed in AKS's `cilium-config` - no agent tuning (eg ICMP reject on deny) is possible.

## Open items

- Confirm on the live cluster (`kubectl -n kube-system get pods -l app=konnectivity-agent -o wide`) whether konnectivity-agent is host-networked - if so, the cert-manager `allowIngressFrom` exception is redundant and can go.
- Confirm the Envoy proxy pod labels on the deployed Envoy Gateway version (`kubectl -n envoy-gateway-system get pods --show-labels`) match `gateway.podLabels`.
- Before enabling `catchAll`, compare `kubectl get ns` against `catchAll.excludeNamespaces` - any AKS add-on or extension namespace (eg `aks-istio-*`, `flux-system`, `dataprotection-microsoft`) must be added first.
- Optionally deny the Azure WireServer `168.63.129.16/32` in `denyEgressCidrs` too - pods have no need for it (DNS goes via CoreDNS); not done yet because a pod with `dnsPolicy: Default` would lose DNS.
