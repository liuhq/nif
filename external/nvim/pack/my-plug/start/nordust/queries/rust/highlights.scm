;; extends

(call_expression
  function: (field_expression
    field: (field_identifier) @function.method.call))

(lifetime_parameter
  name: (lifetime) @attribute (#set! priority 105))

((lifetime
  (identifier)) @attribute (#set! priority 105))
