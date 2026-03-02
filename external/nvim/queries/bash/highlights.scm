;; extends

(command
  argument: (_) @variable.parameter.followCommand
  (#match? @variable.parameter.followCommand "^(-|--|\\+).*"))

; (command
;   argument: (_) @variable.parameter.path (#set! priority 105)
;   (#match? @variable.parameter.path "^(\\./|\\.\\./|~|/)(($\\w+|$\\{\\w+\\}|\\w+)(/($\\w+|$\\{\\w+\\}|\\w+))*)\\S*$"))
;
; ((string_content) @variable.parameter.path (#set! priority 105)
;   (#match? @variable.parameter.path "^(\\./|\\.\\./|~|/)(($\\w+|$\\{\\w+\\}|\\w+)(/($\\w+|$\\{\\w+\\}|\\w+))*)\\S*$"))
;
; (variable_assignment
;   value: (_) @variable.parameter.path (#set! priority 105)
;   (#match? @variable.parameter.path "^(\\./|\\.\\./|~|/)(($\\w+|$\\{\\w+\\}|\\w+)(/($\\w+|$\\{\\w+\\}|\\w+))*)\\S*$"))

((simple_expansion) @variable (#set! priority 105))
((expansion) @variable (#set! priority 105))
