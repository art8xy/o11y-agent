{{- define "custom.opentelemetry_demo.title" -}}
{{- if gt (len .Alerts.Resolved) 0 -}}
[RESOLVED: {{ len .Alerts.Resolved }}]
{{- end -}}
{{- if gt (len .Alerts.Firing) 0 -}}
[FIRING: {{ len .Alerts.Firing }}]
{{- end -}}
{{- end -}}

{{- define "custom.opentelemetry_demo.message" -}}
{{ range .Alerts.Resolved }}
{{ template "custom.opentelemetry_demo.message.body" . }}
{{ end -}}
{{ range .Alerts.Firing }}
{{ template "custom.opentelemetry_demo.message.body" . }}
{{ end -}}
{{- end -}}

{{ define "custom.opentelemetry_demo.message.body" -}}
Summary: {{ .Annotations.summary }}
Description: {{ .Annotations.description }}
{{- end -}}