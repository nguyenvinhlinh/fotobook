$ ->
    split = (val) ->
        val.split /,\s*/

    extractLast = (term) ->
        split(term).pop()

    $('#tags').autocomplete
        source: (request, response) ->
          $.ajax
            url: 'http://localhost:3000/ac_tag'
            dataType: 'json'
            data: term: extractLast(request.term)
            success: (data) ->
              response data
              return
          return
        minLength: 2
        select: (event, ui) ->
          term = split(@value)
      # the text of textfield
          term.pop()
      # remove the last element of array
          term.push ui.item.value
      # add an ele to the array, result of selected text
          term.push ''
          @value = term.join(', ')
          false
        open: ->
          $(this).removeClass('ui-corner-all').addClass 'ui-corner-top'
          return
        close: ->
          $(this).removeClass('ui-corner-top').addClass 'ui-corner-all'
          return
    $container = $('#container')
    $container.masonry
        columnWidth: 200
        itemSelector: '.item'
    $container.imagesLoaded ->
        $container.masonry()
        return
  return
  


  
