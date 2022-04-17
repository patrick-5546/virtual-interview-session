const path = require('path');
const fs = require('fs');
const Database = require("./Database.js");
const express = require('express');
const {spawn} = require('child_process');
var cors = require('cors');
const { json } = require('express/lib/response');
const { dirname } = require('path/posix');
const DATABASE_NAME = 'getstarted';
const DATABASE_ADMIN_USERNAME = '2hyungyu';
const DATABASE_ADMIN_PASSWORD = '*';
const DATABASE_URL = 'mongodb+srv://2hyungyu:Daniel5642*@getstarted.rsnln.mongodb.net/myFirstDatabase?retryWrites=true&w=majority';
var db = new Database(DATABASE_URL, DATABASE_NAME);
const {PythonShell} = require('python-shell');
const average = arr => arr.reduce((a,b) => a + b, 0) / arr.length;
var check = 0;

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

var feedbackSchemaFields = [
	"email",
	"session",
	"feedback"
];

var imageSchemaFields = [
	"feedback"
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
const port = 5000;
const clientApp = path.join(__dirname, 'client');

// express app
let app = express();

app.use(express.json({limit:'50mb', extended : true})) 						// to parse application/json
app.use(express.urlencoded({ limit:'50mb', extended: true })) // to parse application/x-www-form-urlencoded
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


app.get('/api/start', function (req,res) {
	var jsonBody = req.body;
	check = 1;
	console.log(check);
	db.passdocument().then(function(result) {
	})
	db.removedocument().then(function(result) {
		res.json('done')
	})
});

app.get('/api/stop', function (req, res) {
	check = 0;
	console.log(check)
	res.json('done')
});



app.get('/api/javascript', function (req, res) {
	db.getJSquestion().then(function(js_questions) {
		res.json(js_questions);
	})
});



app.get('/api/c', function (req, res) {
	db.getCquestion().then(function(c_questions) {
		res.json(c_questions);
	})
});

app.get('/api/cplus', function (req, res) {
	db.getCplusquestion().then(function(cplus_questions) {

		res.json(cplus_questions);
	})
});

app.get('/api/python', function (req, res) {
	db.getPythonquestion().then(function(python_questions) {

		res.json(python_questions);
	})
});

app.get('/api/hardware', function (req, res) {
	db.getHardwarequestion().then(function(hardware_questions) {

		res.json(hardware_questions);
	})
});

app.get('/api/behavioural', function (req, res) {
	db.getBehaviorualquestion().then(function(behave_questions) {

		res.json(behave_questions);
	})
});




app.post('/api/image', function (req, res, next) {
	console.log('fffffffffffffffffffffffffffffffffffffffffffffffffffffffff')
	var jsonBody = req.body.img

if(check == 1){
	fs.writeFile(__dirname + '/cnn/test.txt', jsonBody.toString(), err => {
		if (err) {
		  console.error(err)
		}
		console.log('file written successfully');
	  })



	  var options = {
		//mode: 'text',
		//pythonPath: 'path/to/python',
		//pythonOptions: ['-u'],
		//scriptPath: 'path/to/my/scripts',
		args: [__dirname + '/cnn/test.txt']
	  };


	  PythonShell.run(__dirname + '/cnn/cnn.py', options, function (err, results) {
		if (err) throw err;
		console.log('finished');
		var dataToSend = results.toString();
		console.log(dataToSend);
		var checkthis = {
			"feedback" : dataToSend,
	  	};
	  //var cbody = JSON.parse(checkthis);
		if(results!=null) {
			db.createfeedback(checkthis).then(function(feedback){
				res.json('done');
			})
		} else {
			res.status(400).send("Cannot add user: user schema mismatch.");
		}

	  });
	}
	else
		res.json('done')
/*
	  // spawn new child process to call the python script
	  console.log(__dirname + '\\cnn\\test.txt');
	  //const python = spawn('python', [__dirname + '/cnn/cnn.py', jsonBody]);
	  const python = spawn('python', [__dirname + '/cnn/cnn.py', __dirname + '/cnn/base64test.txt']);
	  // collect data from script

	  python.stdout.on('data', function (data) {
	   console.log('Pipe data from python script ...');
	   dataToSend = data.toString();
	   console.log(dataToSend);
	  });
	  // in close event we are sure that stream from child process is closed
	  python.on('close', (code) => {
	  console.log(`child process close all stdio with code ${code}`);
	  // send data to browser
	  console.log('done');
	  });
*/


/*

	if(isSchemaValid(imageSchemaFields, jsonBody)) {
		db.createimage(jsonBody).then(function(feedback){
			res.json(feedback);
		})
	} else {
		res.status(400).send("Cannot add user: user schema mismatch.");
	}
	*/
});


app.post('/api/audio', function (req, res, next) {
	//console.log(req)
	if(check == 1){
		var jsonBody = req.body.wav


		fs.writeFile(__dirname + '/audio.json', jsonBody.toString(), err => {
			if (err) {
			console.error(err);
			}
			console.log('file written successfully');
		})


		var options = {
			//mode: 'text',
			//pythonPath: 'path/to/python',
			//pythonOptions: ['-u'],
			//scriptPath: 'path/to/my/scripts',
			args: [__dirname + '/audio.json']
		};

		PythonShell.run('gcpCombined.py', options, function (err, results) {
			if (err) throw err;
			console.log(results)
			var dataToSend = results.toString();
			var checkthis = {
				"feedback" : dataToSend,
			};
		//var cbody = JSON.parse(checkthis);
			if(results!=null) {
				db.createfeedback2(checkthis).then(function(feedback){
					res.json('done');
				})
			} else {
				res.status(400).send("Cannot add user: user schema mismatch.");
			}
			console.log('finished');
			console.log(results);
		});
	}
	else
		res.json('done')
/*
	  var dataToSend;
	  // spawn new child process to call the python script
	  const python = spawn('python', [__dirname + '/cnn/script1.py', JSON.stringify(jsonBody)]);
	  // collect data from script
	  python.stdout.on('data', function (data) {
	   console.log('Pipe data from python script ...');
	   dataToSend = data.toString();
	  });
	  // in close event we are sure that stream from child process is closed
	  python.on('close', (code) => {
	  console.log(`child process close all stdio with code ${code}`);
	  // send data to browser
	  console.log(dataToSend);
	  });
*/

/*

	if(isSchemaValid(imageSchemaFields, jsonBody)) {
		db.createimage(jsonBody).then(function(feedback){
			res.json(feedback);
		})
	} else {
		res.status(400).send("Cannot add user: user schema mismatch.");
	}
	*/
});




/*
app.post('/api/image2', function (req, res, next) {
	console.log('fffffffffffffffffffffffffffffffffffffffffffffffffffffffff')
	var jsonBody = req.body;


	var dataToSend;
	// spawn new child process to call the python script
	const python = spawn('python', ['script1.py' , req.body] );
	// collect data from script
	python.stdout.on('data', function (data) {
	 console.log('Pipe data from python script ...');
	 dataToSend = data.toString();
	});
	// in close event we are sure that stream from child process is closed
	python.on('close', (code) => {
	console.log(`child process close all stdio with code ${code}`);
	// send data to browser
	});



	if(jsonbody != null) {
		db.createfeedback2(jsonBody).then(function(feedback){
			res.json(feedback);
		})
	} else {
		res.status(400).send("Cannot add user: user schema mismatch.");
	}

});

*/
app.post('/api/feedback', function (req, res) {
	var jsonBody = 	req.body;
	if(isSchemaValid(feedbackSchemaFields, jsonBody)) {
		db.createfeedback(jsonBody).then(function(feedback){
			res.json(feedback);
		})
	} else {
		res.status(400).send("Cannot add feedback: user schema mismatch.");
	}
});

app.get('/api/feedback1', function (req, res) {
	console.log(req.query.email);
	db.getfeedbyEmail(req.query.email).then(function(feedback) {
		if(feedback != null) {
			delete feedback.email;
			var array = [];
			//array = feedback.feedback;
			array = feedback.feedback.map(i=>Number(i));
			var avg = average(array);
			res.json(avg.toString());
		} else {
			res.status(404).send("No feedback with the specified email was found.");
		}
	})
});

app.get('/api/feedback2', function (req, res) {
	console.log(req.query.email);
	db.getfeedbyEmail2(req.query.email).then(function(feedback) {
		if(feedback != null) {
			delete feedback.email;
			res.json(feedback);
		} else {
			res.status(404).send("No feedback with the specified email was found.");
		}
	})
});

app.get('/api/feedback3', function (req, res) {
	console.log(req.query.email);
	db.getfeedbyEmail3(req.query.email).then(function(feedback) {
		if(feedback != null) {
			delete feedback.email;
			var array = [];
			//array = feedback.feedback;
			array = feedback.feedback.map(i=>Number(i));
			var avg = average(array);
			res.json(avg.toString());
		} else {
			res.status(404).send("No feedback with the specified email was found.");
		}
	})
});

app.get('/api/feedback4', function (req, res) {
	console.log(req.query.email);
	db.getfeedbyEmail4(req.query.email).then(function(feedback) {
		if(feedback != null) {
			delete feedback.email;
			res.json(feedback);
		} else {
			res.status(404).send("No feedback with the specified email was found.");
		}
	})
});
  
// port must be set to 3000 because incoming http requests are routed from port 80 to port 8080
app.listen(6000, function () {
    console.log('Node app is running on port 3000');
});
