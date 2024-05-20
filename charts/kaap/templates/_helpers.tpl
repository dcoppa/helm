{{/*
Expand the name of the chart.
*/}}
{{- define "kaap.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kaap.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "kaap" | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "kaap-%s" $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kaap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kaap.labels" -}}
{{ include "kaap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "kaap.chart" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kaap.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kaap.name" . }}
{{- end }}

{{/*
Create the name of the operator service account to use
*/}}
{{- define "kaap.serviceAccountName" -}}
{{- default (printf "%s-sa-%s-%s-%s-%s" .Values.k8sPrefix .Values.customer .Values.purpose (include "kaap.fullname" .) .Values.stage) .Values.serviceAccount.name }}
{{- end }}
