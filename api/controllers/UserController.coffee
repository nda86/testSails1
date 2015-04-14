module.exports =

	createF: (req,res) ->
		res.view()

	create: (req,res,next) ->
		UserObj =
				username: req.param 'username'
				firstname: req.param 'firstname'
				lastname: req.param 'lastname'
				email: req.param 'email'
				url: req.param 'url'
				password: req.param 'password'
				confirm_password: req.param 'confirm_password'
		User.create UserObj, (err,user) ->
			if err
				req.session.flash = {err: err}
				return res.redirect '/user/createF'
			req.session.access = on
			req.session.User = user
			user.online = on
			user.save (err,user) ->
				return next err if err
				return res.redirect '/user/readF/' + user.username

	readF: (req,res,next) ->
		username = decodeURIComponent req.param 'id'
		User.findOne {username: username}, (err,user) ->
			return next err if err
			return next() if !user
			res.view {user: user}

	index: (req,res,next) ->
		User.find (err,users) ->
			return next err if err
			res.view {users: users}

	'delete': (req,res,next) ->
		username = decodeURIComponent req.param 'id'
		User.destroy {username: username}, (err) ->
			return next err if err
			res.redirect '/user/index'

	updateF: (req,res,next) ->
		username = decodeURIComponent req.param 'id'
		User.findOne {username: username}, (err,user) ->
			return next err if err
			res.view {user: user}

	update: (req,res,next) ->
		if req.session.User.admin
			UserObj =
				firstname: req.param 'firstname'
				lastname: req.param 'lastname'
				email: req.param 'email'
				url: req.param 'url'
				adminProof: req.param 'adminProof'
				adminToggle: req.param 'adminToggle'
		else
			UserObj =
				firstname: req.param 'firstname'
				lastname: req.param 'lastname'
				email: req.param 'email'
				url: req.param 'url'
		username = decodeURIComponent req.param 'id'
		User.update {username: username}, UserObj, (err,user) ->
			if err
				req.session.flash = {err: err}
				return res.redirect '/user/updateF/' + username
			res.redirect '/user/index'