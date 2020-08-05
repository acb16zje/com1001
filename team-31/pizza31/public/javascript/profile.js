/* Written by Group 31 - Zer Jun Eng, 2017 */
/* Javascript for the front end order page */

function isNumberKey(evt) {
  var charCode = (evt.which) ? evt.which : event.keyCode
  if (charCode > 31 && (charCode < 48 || charCode > 57)) {
    return false;
  }
  return true;
}
