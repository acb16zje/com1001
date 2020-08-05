/* Written by Group 31 - Zer Jun Eng, 2017 */
/* Javascript for the front end order history page */

$(document).ready(function () {
  $('#order_history').DataTable({
    "responsive": true,
    "lengthChange": false,
    "paging": false,
    "language": {
      "emptyTable": "You have not placed any order."
    }
  });

  $('#special_offers').DataTable({
    "responsive": true,
    "lengthChange": false,
    "paging": false,
    "language": {
      "emptyTable": "You don't have any special offers."
    }
  });
});
