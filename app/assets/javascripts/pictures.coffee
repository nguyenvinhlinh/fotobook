$(document).on "page:change", ->
    split = (val) ->
        val.split /,\s*/

    extractLast = (term) ->
        split(term).pop()

    $('#tags').autocomplete(
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
          term.push ui.item.tag
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
    ).data('ui-autocomplete')._renderItem = (ul,item) ->
      $('<li></li>').data('item.autocomplete', item).append(item.tag).appendTo(ul)
    $.colorbox.remove()  
    $('.photoset-grid-lightbox').photosetGrid
      gutter: '2px'
      rel: 'pictures'
      highresLinks: true
      onComplete: ->
        $('.photoset-grid-lightbox').attr('style', '')
        $('.photoset-grid-lightbox a').colorbox
          photo:true
          scalePhotos: true
          maxHeight: '90%'
          maxWidth: '90%'
        return
    return
return
