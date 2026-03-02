;; extends

((private_property_identifier) @variable.member.private)

(call_expression
  function: (member_expression
    property: (private_property_identifier) @function.method.call))
