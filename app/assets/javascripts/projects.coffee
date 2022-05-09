# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener "turbolinks:load", () ->
  if !document.querySelector('.projects.show')
    return
    
  document.querySelector('#bug_status').parentNode.style.display = 'none'
  statuses = document.querySelector('#bug_status').innerHTML

  document.querySelectorAll('input[name="bug[category]"]').forEach (input) ->
    input.addEventListener 'change', (e) ->
      type = document.querySelector('input[name="bug[category]"]:checked').value
      if type == 'feature'
        status = statuses.replace('<option value="resolved">Resolved</option>', '')
      else if type == 'bug'
        status = statuses.replace('<option value="completed">Completed</option>', '')

      document.querySelector('#bug_status').innerHTML = status
      document.querySelector('#bug_status').parentNode.style.display = 'block'
