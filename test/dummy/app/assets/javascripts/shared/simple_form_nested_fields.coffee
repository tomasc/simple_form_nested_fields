selector = 'div.simple_form_nested_fields'
$(selector).SimpleFormNestedFields()

new MutationObserver((mutations) ->
  mutations.forEach (mutation) ->
    $(selector).SimpleFormNestedFields()
).observe document.documentElement, { childList: true, subtree: true }
