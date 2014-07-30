# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

textarea = document.getElementById 'status_content'
count = document.getElementById 'charCount'
button = document.getElementById 'submitID'

countChars = (e) ->
	len = textarea.value.length
	count.innerHTML = len
	if len > 140
		count.className = "limit"
		button.setAttribute "disabled", "disabled"
	else
		count.className = ""
		button.removeAttribute "disabled"

textarea.addEventListener "keyup", countChars, false
textarea.addEventListener "keydown", countChars, false