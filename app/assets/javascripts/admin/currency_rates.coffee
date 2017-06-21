$(window).on('turbolinks:load', ->
  $('#previous_values').on('click', 'a', (e) ->
    e.preventDefault()
    $('#currency_rate_value').val $(this).find('.val').text()
    )
  )
