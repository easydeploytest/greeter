{{/*
Full name: {name}-{env}
*/}}
{{- define "app.fullname" -}}
{{- printf "%s-%s" .Values.name .Values.env }}
{{- end }}

{{/*
Domain: {name}-{env}.{team}.{clusterIP}.nip.io
For prod env: {name}.{team}.{clusterIP}.nip.io
*/}}
{{- define "app.domain" -}}
{{- if eq .Values.env "prod" }}
{{- printf "%s.%s.%s.nip.io" .Values.name .Values.team .Values.clusterIP }}
{{- else }}
{{- printf "%s-%s.%s.%s.nip.io" .Values.name .Values.env .Values.team .Values.clusterIP }}
{{- end }}
{{- end }}

{{- define "app.labels" -}}
app.kubernetes.io/name: {{ .Values.name }}
app.kubernetes.io/instance: {{ include "app.fullname" . }}
app.kubernetes.io/part-of: easy-deploy
app.kubernetes.io/managed-by: devspace
easy-deploy/team: {{ .Values.team }}
easy-deploy/env: {{ .Values.env }}
{{- end }}
