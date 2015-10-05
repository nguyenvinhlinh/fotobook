module.exports = function(selector){
  $(selector).colorbox(
    {
      rel: 'pictures',
      photo: true,
      maxWidth: "90%",
      maxHeight: "95%"
    }
  );
  $("#cboxInfo").click(function(){
    var $image_tag = $.colorbox.element();
    window.location.href = $image_tag.attr('hrefto');
  });
}