var gridlayout = require('../modules/gridlayout');
var loadMoreImagePromise = require('../modules/ajaxImage');
var setupColorbox = require('../modules/colorbox');

var $grid = gridlayout('.grid');
setupColorbox('img');
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