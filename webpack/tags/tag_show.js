var gridlayout = require('../modules/gridlayout');
var setupColorbox = require('../modules/colorbox');
var loadMoreImagePromise = require('../modules/ajaxImage');
gridlayout(".grid");
$.colorbox.remove();
setupColorbox("img");