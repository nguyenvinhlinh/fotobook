// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require jquery-ui.min
//= require turbolinks
//= require_tree .
// $(function() {
//   function split( val ) {
// 	return val.split( /,\s*/ );
//   }
//   function extractLast( term ) {
// 	return split( term ).pop();
//   }
//   $("#tags").autocomplete({
// 	source: function(request, response){
// 	  $.ajax({
// 		url: "http://localhost:3000/ac_tag",
// 		dataType: "json",
// 		data: {
// 		  term: extractLast(request.term)
// 		},
// 		success: function(data){
// 		  response(data);
// 		}
// 	  });
// 	},
// 	minLength: 2,
// 	select: function( event, ui ) {
// 	  /*log( ui.item ?
// 		   "Selected: " + ui.item.label :
// 		   "Nothing selected, input was " + this.value);*/
	  
// 	  //alert("abc");
// 	  //this.value => the text of textfeld, in here, it's #tags
// 	  var term = split(this.value); // the text of textfield
// 	  term.pop(); // remove the last element of array
// 	  term.push(ui.item.value); // add an ele to the array, result of selected text
// 	  term.push("");
// 	  this.value = term.join(", ")
// 	  return false;
// 	},
// 	open: function() {
// 	  $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
// 	},
// 	close: function() {
// 	  $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
// 	}
//   });
// });
