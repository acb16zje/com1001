/* Written by Group 31 - Zer Jun Eng, 2017 */
/* Javascript for the front end order page */

$(document).ready(function () {
  $('#orders').DataTable({
    "responsive": true,
    "lengthChange": false,
    "paging": false,
    "language": {
      "emptyTable": "Your Shopping Basket is Empty"
    }
  });
});

$(document).ready(function () {
  $('input').iCheck({
    checkboxClass: 'icheckbox_square-blue',
    radioClass: 'iradio_square-blue',
  });
});

function isNumberKey(evt) {
  var charCode = (evt.which) ? evt.which : event.keyCode
  if (charCode > 31 && (charCode < 48 || charCode > 57)) {
    return false;
  }
  return true;
}
