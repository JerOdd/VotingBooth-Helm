{{- define "common.sealedSecret" -}}
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  name: {{ .Values.name }}
  namespace: {{ .Values.namespace }}
spec:
  encryptedData:
    {{ range $k, $v := .Values.sealedSecret.vars -}}
    {{ $k }}: {{ $v | quote }}
    {{ end }}
{{- end }}
