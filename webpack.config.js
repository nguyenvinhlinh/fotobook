var path = require('path');
module.exports = {
  context: path.join(__dirname, "webpack"),
  entry: {
    picture: "./pictures/picture.js",
    my_picture: "./pictures/my_picture.js"
  },
  output: {
    filename: '[name].bundle.js',
    path: path.join(__dirname, "app", "assets", "javascripts")
  }
}