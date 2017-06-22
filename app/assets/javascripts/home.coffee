document.addEventListener('DOMContentLoaded', (ev) ->
  el = document.getElementById('app_el')
  
  window.App = new Vue(
    el: el
    template: '#app_template'
    data: {
      value: Number(el.dataset.value)
    }
    computed: {
      fmtValue: ->
        @value.toFixed(3)
    }
  )
)
