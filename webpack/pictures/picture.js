var gridlayout = require('./gridlayout');
var loadMoreImagePromise = require('./ajaxImage');
var setupColorbox = require('./colorbox_setup');
var $grid = gridlayout('.grid');
$.colorbox.remove();
// Setup action on the colorbox, `I` action
setupColorbox("img");
// Setup action on the button
$("#loadmore-button").click(function(){
  var promise = loadMoreImagePromise("/pictures/loadAjaxAllImage", window.currentPage + 1);
  $("#loadmore-button").prop("disabled", true);
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
    $("#loadmore-button").prop("disabled", false);
  })
  .catch(function(data){
    $("#loadmore-button").hide();
  });
});