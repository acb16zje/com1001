/* Written by Group 31 - Zer Jun Eng, 2017 */
/* Javascript for the all control panel pages */

$(document).ready(function () {
  $('#shef_statistics').DataTable({
    "lengthMenu": [[5, 10, 20, -1], [5, 10, 20, "All"]]
  });

  $('#lon_statistics').DataTable({
    "lengthMenu": [[5, 10, 20, -1], [5, 10, 20, "All"]]
  });

  $('#pizzas').DataTable({
    "lengthMenu": [[5, 10, 20, -1], [5, 10, 20, "All"]]
  });

  $('#deals').DataTable({
    "lengthMenu": [[5, 10, 20, -1], [5, 10, 20, "All"]]
  });

  $('#accounts').DataTable();

  $('#pending_orders').DataTable({
    "lengthMenu": [[15, 30, 50, -1], [15, 30, 50, "All"]]
  });

  $('#active_orders').DataTable({
    "lengthMenu": [[15, 30, 50, -1], [15, 30, 50, "All"]]
  });

  $('#completed_orders').DataTable({
    "lengthMenu": [[15, 30, 50, -1], [15, 30, 50, "All"]]
  });

  $('#cancelled_orders').DataTable({
    "lengthMenu": [[15, 30, 50, -1], [15, 30, 50, "All"]]
  });

  $('#special_offers').DataTable();
});
