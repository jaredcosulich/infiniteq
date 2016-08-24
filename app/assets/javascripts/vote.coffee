initVote = ->
  $('.new_question_vote, .new_answer_vote').on 'ajax:success', (e, data, status, xhr) ->
    $(this).closest('.question, .answer').replaceWith(data)
    initVote()

$(document).ready(initVote)
$(document).on('page:load', initVote)
