{{/* vim: set filetype=mustache: */}}

{{- define "kyverno.labels.merge" -}}
{{- $labels := dict -}}
{{- range . -}}
  {{- $labels = merge $labels (fromYaml .) -}}
{{- end -}}
{{- with $labels -}}
  {{- toYaml $labels -}}
{{- end -}}
{{- end -}}

{{- define "kyverno.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kyverno.chartVersion" -}}
{{- .Chart.Version | replace "+" "_" -}}
{{- end -}}

{{- define "kyverno.labels.helm" -}}
helm.sh/chart: {{ template "kyverno.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "kyverno.labels.version" -}}
app.kubernetes.io/version: {{ template "kyverno.chartVersion" . }}
{{- end -}}

{{- define "kyverno.labels.common" -}}
{{- template "kyverno.labels.merge" (list
  (include "kyverno.labels.helm" .)
  (include "kyverno.labels.version" .)
  (toYaml .Values.customLabels)
) -}}
{{- end -}}

{{- define "kyverno.matchLabels.common" -}}
app.kubernetes.io/part-of: "kyverno-crds"
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "kyverno.labels.component" -}}
app.kubernetes.io/component: {{ . }}
{{- end -}}

{{- define "kyverno.crds.matchLabels" -}}
{{- template "kyverno.labels.merge" (list
  (include "kyverno.matchLabels.common" .)
  (include "kyverno.labels.component" "crds")
) -}}
{{- end -}}

{{- define "kyverno.crds.labels" -}}
{{- template "kyverno.labels.merge" (list
  (include "kyverno.labels.common" .)
  (include "kyverno.crds.matchLabels" .)
  (toYaml .Values.customLabels)
) -}}
{{- end -}}
