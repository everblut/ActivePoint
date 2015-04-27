
//= require jquery
//= require jquery_ujs
//= require moment
//= require jquery-ui-timepicker-addon
$(document).ready(function() {
  jQuery('input.hasDatetimePicker').datetimepicker({ format: "DD/MM/YYYY hh:mm a"});
});
