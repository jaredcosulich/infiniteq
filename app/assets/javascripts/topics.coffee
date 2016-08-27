initDetails = ->
  details = $('.ask_a_question .details')
  height = details.height()

  details.focus -> $(this).height('3em')
  details.blur -> $(this).height(height)

$(document).on('turbolinks:load', initDetails)
