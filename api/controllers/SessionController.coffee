 # SessionController
 #
 # @description :: Server-side logic for managing sessions
 # @help        :: See http://links.sailsjs.org/docs/controllers
bcrypt = require 'bcrypt'

module.exports =

	createF: (req,res) ->
		res.view()

	create: (req,res,next) ->
		if (!req.param('username') or !req.param('password'))
			usernamePasswordRequiredError = [
				name:
					'usernamePasswordRequired'
				message:
					'You must enter both a username and password'
			]
			req.session.flash = {err: usernamePasswordRequiredError}
			return res.redirect '/session/createF'
		User.findOne {username: req.param 'username'}, (err,user) ->
			return next err if err
			if !user
				noAccountError = [
					name:
						'noAccount'
					message:
						"The username: #{req.param 'username'} not found"
				]
				req.session.flash = {err: noAccountError}
				return res.redirect '/session/createF'
			bcrypt.compare req.param('password'), user.password, (err,valid) ->
				return next err if err
				if !valid
					noAccessError =[
						name:
							'noAccess'
						message:
							'Wrong Password'
					]
					req.session.flash = {err: noAccessError}
					return res.redirect '/session/createF'
				req.session.access = on
				req.session.User = user
				user.online = on
				user.save (err,user) ->
					return next err if err
					return res.redirect '/user' if user.admin is on
					return res.redirect '/user/readF/' + user.username
	destroy: (req,res,next) ->
		User.update {username: req.session.User.username}, {online: off}, (err) ->
			return next err if err
			req.session.destroy()
			return res.redirect 'app/index'
