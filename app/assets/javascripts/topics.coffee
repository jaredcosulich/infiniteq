initExpandable = ->
  $('.expandable').each (index, expandable) ->
    do (expandable) ->
      expandable = $(expandable)
      height = expandable.height()

      expandable.focus -> expandable.height((expandable.data('expanded-height') || 200))
      expandable.blur -> expandable.height(height) if expandable.val().length == 0

$(document).on('turbolinks:load', initExpandable)
