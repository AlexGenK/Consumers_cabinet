# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  today = new Date
  mm = today.getMonth() + 1
  yy = today.getFullYear()
  strdate = mm + '/1/' + yy
  $('#archdate').datetimepicker
    defaultDate: strdate
    viewMode: 'years'
    format: 'MM/YYYY'
    widgetPositioning:
      horizontal: 'right'
      vertical: 'auto'
  return