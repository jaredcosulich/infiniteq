# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initFlags = ->
  $('.flag-modal form').on 'ajax:success', (e, data, status, xhr) ->
    form = $(this)
    form.closest('.modal').modal('hide')
    setTimeout(( ->
      form.closest('.question').replaceWith(data)
      initFlags()
    ), 500)


$(document).on('turbolinks:load', initFlags)
