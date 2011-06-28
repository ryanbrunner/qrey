$(document).ready(function () {
  var qr_text_area = $("#qr_code_data");
  
  qr_text_area.change(function () {
    bits = string2Bin(qr_text_area.val());
    bits_count = bits.join().length;
    // console.log(bits);
    $(".char_counter").append('\n\nBit count: '+bits_count);
  });
  
  function string2Bin(s) {
    var b = new Array();
    var last = s.length;
    for (var i = 0; i < last; i++) {
      var d = s.charCodeAt(i);
      if (d < 128)
      b[i] = dec2Bin(d);
      else {
        var c = s.charAt(i);
        alert(c + ' is NOT an ASCII character');
        b[i] = -1;
      }
    }
    return b;
  }

  function dec2Bin(d) {
    var b = '';
    for (var i = 0; i < 8; i++) {
      b = (d%2) + b;
      d = Math.floor(d/2);
    }
    return b;
  }

  // alert(string2Bin('ASCII'));
  
});