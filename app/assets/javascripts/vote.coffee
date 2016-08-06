initVote = ->
  $('.new_question_vote').on 'ajax:success', (e, data, status, xhr) ->
    $(this).closest('.question').replaceWith(data)
    initVote()

$(document).ready(initVote)
$(document).on('page:load', initVote)
