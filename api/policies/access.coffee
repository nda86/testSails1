module.exports = (req,res,ok) ->
	if req.session.access
		return ok()
	else
		noAuthorizated =[
			name:
				'noAuthenicated'
			message:
				'You need authenication'
		]
		req.session.flash = {err: noAuthorizated}
		return res.redirect '/session/createF'
