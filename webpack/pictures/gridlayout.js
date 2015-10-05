/*
 * This function apply masonry for selector
 * @selector: string format, for example #id, .class, tag name
 * */
module.exports = function(selector){
  var $object = $(selector).masonry({
    itemSelector: '.grid-item',
    columnWidth: '.grid-sizer',
    percentPosition: true
  });
  $object.imageLoaded().progress(function(){
    $object.masonry('layout');
  });
  return $object;
};