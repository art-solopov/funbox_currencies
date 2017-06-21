$(window).on 'turbolinks:load', ->
  $('input[type="date"]').datetimepicker(
    format: 'DD.MM.YYYY HH:mm'
  )
