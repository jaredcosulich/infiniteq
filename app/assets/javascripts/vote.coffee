initVote = ->
  $('.new_question_vote, .new_answer_vote').on 'ajax:success', (e, data, status, xhr) ->
    $(this).closest('.votes').replaceWith(data)
    initVote()

  $('.already-voted').click -> alert("You've already voted this up.")

$(document).on('turbolinks:load', initVote)
