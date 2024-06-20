{{/* generate the image name for a component*/}}
{{- define "tigera-operator.image" -}}
{{- if and .awsAccountID (not (eq .awsAccountID "")) -}}
{{- .awsAccountID -}}.dkr.ecr.eu-west-1.amazonaws.com/{{- .image -}}:{{- .version -}}
{{- else -}}
{{- .image -}}:{{- .version -}}
{{- end -}}
{{- end -}}

{{/*
generate imagePullSecrets for installation and deployments
by combining installation.imagePullSecrets with toplevel imagePullSecrets.
*/}}

{{- define "tigera-operator.imagePullSecrets" -}}
{{- $secrets := default list .Values.installation.imagePullSecrets -}}
{{- range $key, $val := .Values.imagePullSecrets -}}
  {{- $secrets = append $secrets (dict "name" $key) -}}
{{- end -}}
{{ $secrets | toYaml }}
{{- end -}}
