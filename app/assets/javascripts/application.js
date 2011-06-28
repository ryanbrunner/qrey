// FIXME: Tell people that this is a manifest file, real code should go into discrete files
// FIXME: Tell people how Sprockets and CoffeeScript works
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function () {
  var qr_text_area = $("#qr_code_data");
  qr_text_area.keyup(function () {
    var chars = qr_text_area.val().length;
    
    $(".char_counter").html('Character count: '+chars);
    // console.log(chars);
  });
 
});