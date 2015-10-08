module.exports = function(url, pageNumber){
  var promise = new Promise(
    function(resolve, reject){
      $.ajax({
        url: url,
        data: {
          page: pageNumber
        },
        dataType: 'json',
        method: 'get',
        error: function(xhr, status, error){
          reject(error);
        },
        success: function(data, status, xhr){
          if (data.images.length == 0){
            reject("There is no more pictures");
          } else {
            resolve(data);
          }
        }
      });
    });
  return promise;
}