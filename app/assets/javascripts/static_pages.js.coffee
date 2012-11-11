# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.countChar = (val) ->
  len = val.value.length;
  if (len >= 1025) 
  	val.value = val.value.substring(0, 1024);
  else 
  	$('#charNum').text(1024 - len);
  
