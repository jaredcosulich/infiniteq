initTabs = ->
  $('.nav-tabs a').click (e) ->
    e.preventDefault()
    $(this).tab('show')

$(document).ready(initTabs)
$(document).on('page:load', initTabs)
