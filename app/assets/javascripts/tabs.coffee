updatePagination = (targetHash) ->
  $('.pagination a').each (i, pageLink) ->
    pageLink.href = pageLink.href.split('#')[0] + targetHash

initTabs = ->
  $('.nav-tabs a').click (e) ->
    e.preventDefault()
    $(this).tab('show')

  url = document.location.toString();
  if (url.match('#'))
    targetHash = '#' + url.split('#')[1]
    tab = $('.nav-tabs a[href="' + targetHash + '"]')
    tab.tab('show');
    tab.closest('li').addClass('active')
    updatePagination(targetHash)

  $('.nav-tabs a').on 'shown.bs.tab', (e) ->
    if (history.pushState)
      history.pushState(null, null, e.target.hash);
    else
      window.location.hash = e.target.hash;

    updatePagination(e.target.hash)


$(document).on('turbolinks:load', initTabs)
