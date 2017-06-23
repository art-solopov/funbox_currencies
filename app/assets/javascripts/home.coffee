document.addEventListener('DOMContentLoaded', (ev) ->
  el = document.getElementById('app_el')
  data = el.dataset

  window.App = new Vue(
    el: el
    template: '#app_template'
    data: {
      value: Number(data.value)
    }
    computed: {
      fmtValue: ->
        @value.toFixed(3)
    }
  )

  if Boolean(data.fayeServer)
    SubClient = new Faye.Client(data.fayeServer)
    SubClient.subscribe(
      data.fayeQueue,
      (msg) -> App.value = Number(msg.currentValue)
    )
    window.SubClient = SubClient
)
