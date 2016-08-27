initVote = ->
  $('.new_question_vote, .new_answer_vote').on 'ajax:success', (e, data, status, xhr) ->
    $(this).closest('.vote').replaceWith(data)
    initVote()

$(document).on('turbolinks:load', initVote)
