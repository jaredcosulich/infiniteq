ready = ->
  $('.nav-tabs a').click (e) ->
    console.log($(this), $(this).tab)
    e.preventDefault()
    $(this).tab('show')

$(document).ready(ready)
$(document).on('page:load', ready)
