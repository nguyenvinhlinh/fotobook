var gridlayout = require('../modules/gridlayout');
var setupColorbox = require('../modules/colorbox');
var loadMoreImagePromise = require('../modules/ajaxImage');
$grid = gridlayout(".grid");
$.colorbox.remove();
setupColorbox("img");
$("#loadmore-button").click(function(){
  var promise = loadMoreImagePromise("/tags/loadAjaxImageByTag", window.currentpage + 1);
  $("#loadmore-button").prop("disabled", true);
  promise.then(function(){
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
    console.log('dis');
  })
  .catch(function(data){
    $("#loadmore-button").hide();
    console.log('hide');
  });
});