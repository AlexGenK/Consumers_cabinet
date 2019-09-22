import 'bootstrap4-toggle/js/bootstrap4-toggle.min.js';
import 'bootstrap4-toggle/css/bootstrap4-toggle.min.css';

$(document).on('ready turbolinks:load', function (e) {
   $('input[type=checkbox][data-toggle^=toggle]').bootstrapToggle()
});