# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initFlags = ->
  $('.flag-modal form').on 'ajax:error', (e, data, status, xhr) ->
    $(this).find('.errors').html(data.responseText)

  $('.flag-modal form').on 'ajax:success', (e, data, status, xhr) ->
    form = $(this)
    object_area = form.closest('.question, .answer')
    modal = form.closest('.modal')

    modal.on 'hidden.bs.modal', ->
      object_area.html('<div class="text-center"><i class="fa fa-spinner fa-spin"></i></div>')
      if data.length
        object_area.replaceWith(data)
        initFlags()
      else
        window.location.reload()
    modal.modal('hide')



$(document).on('turbolinks:load', initFlags)
