import $ from 'jquery';

$(document).on('turbolinks:load', function() {
  $('.nav-select').on('change', function(e) {
    var id = $(this).val();
    $('a[href="' + id + '"]').tab('show');
  });
});