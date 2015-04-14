module.exports = (req,res,ok) ->
	isAdmin = req.session.User.admin
	isOwn = req.session.User.username is req.param 'id'
	return ok() if isAdmin or isOwn
	requireAdminOrOwn = [name: 'AccessError', message: 'You must be admin or owner']
	req.session.flash =
		err: requireAdminOrOwn
	return res.redirect '/session/createF'
