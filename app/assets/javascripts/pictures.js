$(document).on("page:change", function(){
  function split(val) {
    return val.split(/,\s*/);
  }
  function extractLast(term){
    return split(term).pop();
  }
  
  $('#tags').bind("keydown", function(event){
    if ( event.keyCode === $.ui.keyCode.TAB && $( this ).autocomplete( "instance" ).menu.active ) {
      event.preventDefault();
    }
  })
  .autocomplete({
    source: function(request, response){
      $.getJSON("http://localhost:3000/tags/ac_tag", {
        term: extractLast(request.term)
      }, response);
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
    select: function(){
      var terms = split(this.value);
      terms.pop();
      terms.push(ui.item.value);
      term.push("");
      this.value = terms.join(", ");
      return false;
    }
  });
  var $grid = $('.grid').masonry({
    itemSelector: '.grid-item',
    columnWidth: '.grid-sizer',
    percentPosition: true
  });
});