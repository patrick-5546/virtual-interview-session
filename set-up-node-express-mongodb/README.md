# Setting Up Node JS + Express + MongoDB
Author: Victor Angelo Parangue

## Prerequisites

Make sure you have Node installed on your system. You can verify it is installed by checking your Node version using this command:

`node -v`

You can [install Node from here](https://nodejs.org/en/download/).

## Install Dependencies (Express)

Our server will use ExpressJS, the most popular NodeJS framework in building web servers. To install it, go to your project's directory and type:

`npm install express`

## Install Nodemon
During development, you'll need to restart the server after every change you make to the server-side code. This is annoying when you are making and testing frequent changes. You can install nodemon which will watch your files and restart the server when a change is detected. Type the following in your project directory:

`npm install --save-dev nodemon`

You can then use it to launch your application:

`nodemon server.js`

Depending on your NodeJS installation, you might need to add the node_modules/.bin directory to your PATH environment variable.

## Install MongoDB

First, install MongoDB. Download the latest [MongoDB Community Server, provided as free and open source software at mongodb.com](https://www.mongodb.com/try/download/community).

Then, install the MongoDB JavaScript driver from NPM by running:

`npm install mongodb`.

You may refer to the official ["Quick Start" guide](https://docs.mongodb.com/drivers/node/quick-start#add-mongodb-as-a-dependency).

## Deploy a MongoDB Database Cluster to the Cloud using Atlas

Follow [this guide to set up your first MongoDB database on the cloud using MongoDB Atlas](https://docs.atlas.mongodb.com/getting-started).

Once you've created a database on the cloud, grab the database URL and a username/password of a database admin user you have configured in Atlas. You now have set up your development environment for a Node JS + Express + MongoDB backend.

## Boilerplate code

Take a look inside [`server.js`](server.js) for some boilerplate code to use Express. It should help you get started coding your web server.

We can use the `mongodb` library to interact with the database. However, the [API provided by the module](https://mongodb.github.io/node-mongodb-native/3.6/api/) are quite low-level and we want to abstract out these details so we don't have to call the low-level methods all the time. So instead, I have written a `Database` object that will carry out the low-level queries. Check out my [initial implementation of `Database`](Database.js). You need to add more methods here depending on what database queries you want to create for your application.


## Next steps

Code your application! Once you are finished, deploy the application onto the cloud platform of your choice (for e.g.: AWS EC2, Google Cloud, Microsoft Azure, and so on..). Happy coding! :)

