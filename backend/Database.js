const { MongoClient, ObjectID, ObjectId } = require('mongodb');	// require the mongodb driver



/**
 * Uses mongodb v3.6+ - [API Documentation](http://mongodb.github.io/node-mongodb-native/3.6/api/)
 * Database wraps a mongoDB connection to provide a higher-level abstraction layer
 * for manipulating the objects in our cpen400a app.
 */
function Database(mongoUrl, dbName){
	if (!(this instanceof Database)) return new Database(mongoUrl, dbName);
	this.connected = new Promise((resolve, reject) => {
		MongoClient.connect(
			mongoUrl,
			{
				useNewUrlParser: true
			},
			(err, client) => {
				if (err) reject(err);
				else {
					console.log('[MongoClient] Connected to ' + mongoUrl + '/' + dbName);
					resolve(client.db(dbName));
				}
			}
		)
	});
	this.status = () => this.connected.then(
		db => ({ error: null, url: mongoUrl, db: dbName }),
		err => ({ error: err })
	);
}

Database.prototype.getUsers = function() {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab all users from the database
			// note: the database must have a collection named 'users' for this to work
			resolve(db.collection('users').find({}).toArray());
		})	
	)
}


Database.prototype.getUserById = function(id) {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given id
			// note: MongoDB uses '_id' as the identifier for documents in a collection
			// also, MongoDB uses an object of type 'ObjectID' for the identifier
			try {
				var object_id = new ObjectID(id);
			} catch(e) {
				// error most likely occured since id passed is not in the proper format for ObjectID creation
				var object_id = id.toString();
			}
			resolve(db.collection('users').findOne({_id: object_id}));
		})	
	)
}


Database.prototype.getUserByEmail = function(email1) {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username
			resolve(db.collection('users').findOne({email: email1}));
		})	
	)
}

Database.prototype.createNewUser = function(user) {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// check if user with the email already exists
			db.collection('users').findOne({email: user.email}).then(function(doesUserExist) {
				if(doesUserExist != null) {
					reject(new Error("User with the given email already exists."))
				} else {
					db.collection('users').insertOne(user, function(err, result) {
						if(err) {
							reject(err)
						} else {
							resolve(result.ops[0]);
						}
					});
				}
			})
		})
	)
}


Database.prototype.removedocument = function() {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username

			db.collection('feedback').deleteMany({});
			resolve(db.collection('feedback').insertOne( { _id:ObjectId("6248ecd86ad653322a4fd438")} ))
		})	
	)
}

Database.prototype.getJSquestion = function() {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username

			resolve(db.collection('questions').aggregate([
				{ $sample: { size: 5 } }
			]).toArray());
		})	
	)
}

Database.prototype.getCquestion = function() {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username

			resolve(db.collection('Cquestions').aggregate([
				{ $sample: { size: 5 } }
			]).toArray());
		})	
	)
}


Database.prototype.getCplusquestion = function() {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username

			resolve(db.collection('C++questions').aggregate([
				{ $sample: { size: 5 } }
			]).toArray());
		})	
	)
}


Database.prototype.getPythonquestion = function() {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username

			resolve(db.collection('python').aggregate([
				{ $sample: { size: 5 } }
			]).toArray());
		})	
	)
}


Database.prototype.getHardwarequestion = function() {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username

			resolve(db.collection('hardware').aggregate([
				{ $sample: { size: 5 } }
			]).toArray());
		})	
	)
}


Database.prototype.getBehaviorualquestion = function() {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username

			resolve(db.collection('behavioural').aggregate([
				{ $sample: { size: 5 } }
			]).toArray());
		})	
	)
}


Database.prototype.createfeedback = function(feedback) {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username


			/*
			db.collection('feedback').insertOne(feedback, function(err, result) {
				if(err) {
					reject(err)
				} else {
					resolve(result.ops[0]);
				}
			});
			*/


			/*
			var data = feedback.feedback.toString()
			db.collection('feedback').updateOne({_id:ObjectId("6248ecd86ad653322a4fd438")}, {$set: {feedback:data}}, function(err, result) {
				if(err) {
					reject(err)
				} else {
					resolve(result);
				}
			})

*/
			var data = feedback.feedback.toString()
			db.collection('feedback').updateOne({_id:ObjectId("6248ecd86ad653322a4fd438")},  { $push: { feedback: data } }, function(err, result) {
				if(err) {
					reject(err)
				} else {
					resolve(result);
				}
			})
			
		})
	)
}

Database.prototype.createfeedback2 = function(feedback) {
	var data = feedback.feedback.toString()
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username

			db.collection('feedback2').updateOne({_id:ObjectId("6248e7cc6ad653322a4fd437")},{$set: {feedback:data}}, function(err, result) {
				if(err) {
					reject(err)
				} else {
					resolve('done');
				}
			});
		})
	)
}

Database.prototype.createimage = function(feedback) {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username

			db.collection('image').insertOne(feedback, function(err, result) {
				if(err) {
					reject(err)
				} else {
					resolve(result.ops[0]);
				}
			});
		})
	)
}
Database.prototype.passdocument = function() {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username
			//array = feedback.feedback;
			//array = feedback.feedback
			db.collection('feedback3').deleteMany({});
			db.collection('feedback').findOne({_id:ObjectId("6248ecd86ad653322a4fd438")}).then(doc => {
				console.log(doc);
		  
				// Inserting the doc in destination collection
				db.collection('feedback3').insertOne(doc)
					.then(d => {
						console.log("Saved Successfully");
					})
					.catch(error => {
						console.log(error);
					})
				})
				
			//var data2 = db.collection('feedback2').findOne({_id:ObjectId("6248e7cc6ad653322a4fd437")}).feedback
			//console.log(data)

			//db.collection('feedback3').insertOne( { _id:ObjectId("6248ecd86ad653322a4fd438")} ,{$set: {feedback:data}})
			db.collection('feedback4').deleteMany({});
			db.collection('feedback2').findOne({_id:ObjectId("6248e7cc6ad653322a4fd437")}).then(doc => {
				//console.log(doc);
		  
				// Inserting the doc in destination collection
				db.collection('feedback4').insertOne(doc)
					.then(d => {
						console.log("Saved Successfully");
					})
					.catch(error => {
						console.log(error);
					})
				})
			
			resolve('done');
		})	
	)
}

Database.prototype.getfeedbyEmail = function(email) {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username
			resolve(db.collection('feedback').findOne({email: email}));
		})	
	)
}

Database.prototype.getfeedbyEmail2 = function(email) {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username
			resolve(db.collection('feedback2').findOne({email: email}));
		})	
	)
}

Database.prototype.getfeedbyEmail3 = function(email) {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username
			resolve(db.collection('feedback3').findOne({email: email}));
		})	
	)
}

Database.prototype.getfeedbyEmail4 = function(email) {
	return this.connected.then(db => 
		new Promise((resolve, reject) => {
			// grab a specific user from the database that matches the given username
			resolve(db.collection('feedback4').findOne({email: email}));
		})	
	)
}

module.exports = Database;

