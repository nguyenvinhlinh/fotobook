var gridlayout = require('./gridlayout');
var loadMoreImagePromise = require('./ajaxImage');
var $grid = gridlayout('.grid');
$.colorbox.remove();
function setupColorbox(selector){
  $(selector).colorbox(
    {
      rel: 'pictures',
      photo: true,
      maxWidth: "90%",
      maxHeight: "95%"
    }
  );
}
// Setup action on the colorbox, `I` action
setupColorbox("img");
$("#cboxInfo").click(function(){
  var $image_tag = $.colorbox.element();
  window.location.href = $image_tag.attr('hrefto');
});
// Setup action on the button
$("#loadmore-button").click(function(){
  var promise = loadMoreImagePromise("/pictures/loadAjaxAllImage", window.currentPage + 1);
  promise.then(function(data){
    window.currentPage += 1;
    for (var i in data.images){
      var dom = $("<div class='grid-item'>" + data.images[i][1] + "</div");
      $grid.append(dom);
      $grid.imagesLoaded(function(){
        $grid.masonry('reloadItems').masonry();
        setupColorbox("img");
      });
    }
  })
  .catch(function(data){
    $("#loadmore-button").hide();
    alert(data);
  });
});