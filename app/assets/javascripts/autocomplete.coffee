initAutocomplete = ->
  buildResult = (resultText, result) ->
    "<div class='result'>" +
    "<a href='/questions/#{result['slug']}'>#{resultText}</a>" +
    "<a href='/questions/#{result['slug']}' class='small'>#{result['topic']['path']}</a></div>"

  highlightSearchTerms = (text, searchTerms) ->
      priorityWord = (term) -> if elasticlunr.defaultStopWords[term] then 0.5 else -0.5
      searchTerms.sort((a,b) -> priorityWord(a) - priorityWord(b)).each (index, term) ->
        text = text.replace(new RegExp(term, 'ig'), "~#{index}~")

      searchTerms.each (index, term) ->
        text = text.replace(new RegExp("~#{index}~", 'ig'), "<span>#{term}</span>")
      return text


  $('.autocomplete').each (index, autoComplete) ->
    do (autoComplete) ->
      autoComplete = $(autoComplete)

      @resultDisplay = $(document.createElement('DIV'))
      @resultDisplay.addClass('autocomplete-search-results')
      position = autoComplete.position()
      @resultDisplay.css(
        left: position.left,
        width: autoComplete.outerWidth(),
        top: position.top + autoComplete.height()
      )
      @resultDisplay.hide()
      autoComplete.parent().append(@resultDisplay)

      @searchIndex = elasticlunr ->
          @addField('text')
          @setRef('id')
          @saveDocument(false)

      @results = {}
      $.get(
        url: autoComplete.data('autocomplete-url'),
        success: (data) =>
          $(data).each (index, info) =>
            @results[info['id']] = info
            @searchIndex.addDoc({id: info['id'], text: info['text']})
      )

      autoCompleteSearch = =>
        search = autoComplete.val()
        searchTerms = $(search.split(/\s/g)).filter(
          (index, term) ->
            (term.length > 0) && (term != '~') && isNaN(term) && !term.match(/~.~/)
        )

        displayHtml = []
        $(@searchIndex.search(search, {expand: true})).each (index, lookup) =>
          return if index >= 10
          result = @results[lookup['ref']]
          text = highlightSearchTerms(result['text'], searchTerms)
          displayHtml.push(buildResult(text, result))

        if displayHtml.length
          @resultDisplay.css(top: autoComplete.position().top + autoComplete.height())
          @resultDisplay.html(displayHtml.join(''))
          @resultDisplay.show()
        else
          @resultDisplay.hide()

      autoComplete.on 'focus', autoCompleteSearch
      autoComplete.on 'keyup', autoCompleteSearch
      autoComplete.on 'blur', => setTimeout((=> @resultDisplay.hide()), 100)


$(document).on('turbolinks:load', initAutocomplete)
