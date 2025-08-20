//= require jquery
//= require datatables.net-bs5

document.addEventListener('DOMContentLoaded', function() {
  var tables = document.querySelectorAll('table.table');
  tables.forEach(function(table) {
    $(table).DataTable();
  });
});
