# /**
#  * AppController
#  *
#  * @description :: Server-side logic for managing apps
#  * @help        :: See http://links.sailsjs.org/docs/controllers
#  */

module.exports =
	index: (req,res,next) ->
		res.view {username: req.session.User}

