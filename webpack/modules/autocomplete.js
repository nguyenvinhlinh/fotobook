module.exports = function(selector){
  function split(term){
    return term.split(/,\s*/);
  }
  function extractLast(term){
    return split(term).pop();
  }
  var $dom = $(selector);
  $dom.autocomplete(
    {
      source: function(request, response){
        $.getJSON(
          "/tags/ac_tag",
          {
            term: extractLast(request.term)
          }, response
        );
      },
      search: function(){
        var term = extractLast(this.value);
        if (term.length < 2){
          return false;
        }
      },
      focus: function(){
        return false;
      },
      select: function(event, ui){
        var terms = split(this.value);
        terms.pop();
        terms.push(ui.item.value);
        terms.push("");
        this.value = terms.join(", ");
        return false;
      }
    }
  )
}