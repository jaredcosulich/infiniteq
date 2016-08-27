initTabs = ->
  $('.nav-tabs a').click (e) ->
    e.preventDefault()
    $(this).tab('show')

$(document).on('turbolinks:load', initTabs)
