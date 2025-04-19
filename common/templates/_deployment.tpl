{{- define "common.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.name }}
  namespace: {{ .Values.namespace }}
  labels:
    app: {{ .Values.name }}
spec:
  replicas: {{ .Values.deployment.replicas }}
  selector:
    matchLabels:
      app: {{ .Values.name }}
  template:
    metadata:
      labels:
        app: {{ .Values.name }}
    spec:
      containers:
      - name: {{ .Values.name }}
        image: "{{ .Values.deployment.image.repository }}:{{ .Values.deployment.image.tag }}"
        ports:
        - containerPort: 8080
        {{- with .Values.deployment.envs }}
          env:
            {{- range $k, $v := . }}
            - name: {{ $k | quote }}
              value: {{ $v | quote }}
            {{- end }}
        {{- end }}
        {{- if .Values.sealedSecrets }}  # Changed from .Values.sealedSecret
        envFrom:
            {{- if .Values.sealedSecrets.vars }}  # Changed from .Values.sealedSecret.vars
            - secretRef:
                name: {{ .Values.name }}
            {{- end }}
        {{- end }}
{{- end }}