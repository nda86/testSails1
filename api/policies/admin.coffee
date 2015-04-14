module.exports = (req,res,ok) ->
	return ok() if req.session.User and req.session.User.admin
	requireAdminError = [name: 'requireAdminError', message: 'You must be admin']
	req.session.flash =
		err: requireAdminError
	return res.redirect '/session/createF'
