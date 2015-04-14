$(document).ready ->
	$('.createForm').validate
		rules:
			username:
				required: on
				minlength: 4
			email:
				required: on
				email: on
			url:
				url: true
			password:
				required: on
				minlength: 6
			confirmPassword:
				required: on
				equalTo: '#password'
		messages:
			username:
				required:'This field is required!'
			password:
				required: "This field is reuired"
				minLength: 'Min length 6'
			confirmPassword:
				required: "This field is reuired"
				equalTo: 'Passwords mismatch'