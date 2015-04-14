bcrypt = require 'bcrypt'

module.exports =
	autoPK: off
	schema: on
	uniqueUsername: off

	types:
		uniqueUsername: (value) ->
			uniqueUsername

	attributes:
		username:
			type: 'string'
			uniqueUsername: on
			minLength: 4
			required: on
		firstname:
			type: 'string'
		lastname:
			type: 'string'
		email:
			required: on
			type: 'string'
			email: on
		url:
			type: 'string'
			url: on
		password:
			type: 'string'
			required: on
			minLength: 6
		admin:
			type: 'boolean'
			defaultsTo: off
		online:
			type: 'boolean'
			defaultsTo: off

		toJSON: ->
			obj = @.toObject()
			delete obj.password
			obj

	beforeValidation: (doc,cb) ->
		if doc.adminProof is 'unchecked'
			if doc.adminToggle is 'on'
				doc.admin = on
			else
				doc.admin = off
		User.findOne {username: doc.username}, (err,record) ->
			@.uniqueUsername = !err and !record
			cb()

	beforeCreate: (doc,cb) ->
		cb {error: ['Password mismatch']} if !doc.password or doc.password isnt doc.confirm_password
		bcrypt.hash doc.password, 10, (err,hash) ->
			cb err if err
			doc.password = hash
			cb()
