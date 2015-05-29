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
    
    wall = new freewall('#container')
    $('.item').each (index) ->
        w = 200 + 50*Math.random()
        h = 200 + 100*Math.random() 
        $(this).css("width", 200)
        $(this).css("height", 200)
        $(this).css("background-size", "contain")
        return
    wall.reset
        fixSize: 0
        selector: '.item'
        animate:true
        cellW: 200
        cellH: 200
        onResize: ->
            wall.fitWidth()
            return
    wall.fitWidth()
    $(window).trigger("resize")
    @mousein = (object) ->
        $(object).find('.copy_div').css("display", "block")
        $(object).find('.download_div').css("display", "block")
        image_url = $(object).css('background-image')
        image_url = image_url.replace('url("', '')
        image_url = image_url.replace('")', '')
        
        $(object).find('.download_div').click ->
            $(object).find('.download_div').attr
                target: '_blank'
                href: image_url
        return
    @mouseout = (object) ->
        $(object).find('.copy_div').css("display", "none")
        $(object).find('.download_div').css("display", "none")
        return
return
