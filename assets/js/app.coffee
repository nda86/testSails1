$(document).ready -> 
	$('.btnDeleteUser').on 'click', (e)->
		e.preventDefault()
		flag = confirm 'Do You really want to delete this user?'
		$(@).parent().submit() if flag