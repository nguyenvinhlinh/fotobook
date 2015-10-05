var gridlayout = require('./gridlayout');
gridlayout('.grid');
$.colorbox.remove();
// Setup action on the colorbox, `I` action
$("img").colorbox(
  {
    rel: 'pictures',
    photo: true
  }
);
$("#cboxInfo").click(function(){
  var $image_tag = $.colorbox.element();
  window.location.href = $image_tag.attr('hrefto');
});