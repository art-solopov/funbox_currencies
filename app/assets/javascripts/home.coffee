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

  if Boolean(data.pusherKey)
    Pusher.logToConsole = true;

    SubClient = new Pusher(data.pusherKey, { cluster: 'eu', encrypted: true })
    SubChannel = SubClient.subscribe(data.queue)

    SubChannel.bind('current', (data) -> App.value = Number(data.currentValue))
    
    window.SubClient = SubClient
    window.SubChannel = SubChannel
)
