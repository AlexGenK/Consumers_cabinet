# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  today = new Date
  mm = ('0' + (today.getMonth() + 1)).slice(-2)
  yy = today.getFullYear()
  strdate = yy + '-' + mm + '-01'
  $('#archdate').datetimepicker
    defaultDate: strdate
    viewMode: 'years'
    format: 'MM/YYYY'
    locale: 'ru'
    widgetPositioning:
      horizontal: 'right'
      vertical: 'auto'
  return