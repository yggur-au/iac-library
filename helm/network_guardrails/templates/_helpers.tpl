{{- define "network-guardrails.fullname" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "network-guardrails.labels" -}}
app.kubernetes.io/name: {{ include "network-guardrails.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Deny selectors matching "any pod NOT in self, extra or peers". Takes a dict:
self (namespace name), extra (list of whole namespaces to leave alone) and
peers (list of {namespace, podLabels}). A peer without podLabels leaves its
whole namespace alone; a peer with podLabels leaves only pods carrying ALL of
those labels alone - one NotIn selector per label, so a pod missing any one
of them matches a deny selector.
*/}}
{{- define "network-guardrails.denySelectors" -}}
{{- $allowed := concat (list .self) .extra -}}
{{- range .peers }}
{{- if has .namespace $allowed }}
{{- fail (printf "network-guardrails: namespace %s appears more than once in the peers for %s (itself, the gateway, kube-system egress or its exceptions) - merge them into one entry" .namespace $.self) }}
{{- end }}
{{- $allowed = append $allowed .namespace }}
{{- end }}
# Exists: NotIn on its own also matches non-pod identities (world, host,
# remote-node, kube-apiserver), which carry no namespace label.
- matchExpressions:
    - key: k8s:io.kubernetes.pod.namespace
      operator: Exists
    - key: k8s:io.kubernetes.pod.namespace
      operator: NotIn
      values: {{ toJson $allowed }}
{{- range .peers }}
{{- $ns := .namespace }}
{{- range $key, $value := .podLabels }}
- matchLabels:
    k8s:io.kubernetes.pod.namespace: {{ $ns }}
  matchExpressions:
    - key: k8s:{{ $key }}
      operator: NotIn
      values: [{{ $value | quote }}]
{{- end }}
{{- end }}
{{- end -}}
