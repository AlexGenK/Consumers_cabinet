import 'bootstrap4-toggle/js/bootstrap4-toggle';
import 'bootstrap4-toggle/css/bootstrap4-toggle.css';

$(document).on('ready turbolinks:load', function (e) {
   $('input[type=checkbox][data-toggle^=toggle]').bootstrapToggle()
});