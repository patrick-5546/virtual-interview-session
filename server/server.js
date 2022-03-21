const path = require('path');
const fs = require('fs');
const Database = require("./Database.js");
const express = require('express');
var cors = require('cors')

const DATABASE_NAME = 'getstarted';
const DATABASE_ADMIN_USERNAME = '2hyungyu';
const DATABASE_ADMIN_PASSWORD = 'Daniel5642*';
const DATABASE_URL = 'mongodb+srv://2hyungyu:Daniel5642*@getstarted.rsnln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority';
var db = new Database(DATABASE_URL, DATABASE_NAME);

// helper function to log all incoming requests to the web server
function logRequest(req, res, next){
	console.log(`${new Date()}  ${req.ip} : ${req.method} ${req.path}`);
	next();
}

// a standard user schema example
var userSchemaFields = [
	"firstName", 
	"lastName", 
	"email", 
	"password", 
	"contactNumber"
];

// helper function to check if array of fields match the obj's fields
function isSchemaValid(fields, obj) {
	for(var i = 0; i < fields.length; i++) {
		if(!obj.hasOwnProperty(fields[i])) {
			return false;
		}
	}
	return true;
}

const host = 'localhost';
const port = 3000;
const clientApp = path.join(__dirname, 'client');

// express app
let app = express();

app.use(express.json()) 						// to parse application/json
app.use(express.urlencoded({ extended: true })) // to parse application/x-www-form-urlencoded
app.use(logRequest);							// logging for debug

// serve static files (client-side)
app.use('/', express.static(clientApp, { extensions: ['html'] }));
app.listen(port, () => {
	console.log(`${new Date()}  App Started. Listening on ${host}:${port}, serving ${clientApp}`);
});

// enable all cross-site domain requests (this is a security breach, do not do in actual production-level app)
app.use(cors());

app.route('/api/users')
	.get(function(req, res, next) {
		console.log('fffffffffffffffffffffffffffffffffffffffffffffffffffffffff')
		db.getUsers().then(function(allUsers) {
			for(var i = 0; i < allUsers.length; i++) {
				delete allUsers[i].password;
				delete allUsers[i]._id;
			}
			res.json(allUsers);
		})
	})
	.post(function (req, res, next) {
		console.log('fffffffffffffffffffffffffffffffffffffffffffffffffffffffff')
		var jsonBody = req.body;
		if(isSchemaValid(userSchemaFields, jsonBody)) {
			db.createNewUser(jsonBody).then(function(newUser) {
				res.json(newUser);
			}, function(err) {
				res.status(400).send(err.message);
			});
		} else {
			res.status(400).send("Cannot add user: user schema mismatch.");
		}
	});


app.get('/api/users/id/:id', function (req, res) {
	db.getUserById(req.params.id).then(function(user) {
		if(user != null) {
			delete user.password;
			res.json(user);
		} else {
			res.status(404).send("No User with the specified ID was found.");
		}
	})
});

app.post('/api/authenticate', function (req,res) {
	var jsonBody = req.body;
	db.getUserByEmail(jsonBody.email).then(function(user) {
		if(user != null) {
			if(jsonBody.password === user.password) {
				res.json(user);
			} else {
				res.status(401).send("Invalid email/password credentials.");
			}
		} else {
			res.status(401).send("Given email is not registered.");
		}
	})
});



