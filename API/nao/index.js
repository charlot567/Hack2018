
var express = require('express'),
    app = express(),
    port = process.env.PORT || 3000;
    mongoose = require('mongoose'),
    InterestPoint = require('./api/models/interestPointModel'), //created model loading here
    User = require('./api/models/userModel'), //created model loading here
    DidYouKnow = require('./api/models/didYouKnowModel'), //created model loading here
    Mission = require('./api/models/missionModel'), //created model loading here
    bodyParser = require('body-parser');

// mongoose instance connection url connection
mongoose.Promise = global.Promise;
mongoose.connect('mongodb://localhost/nao');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var routes = require('./api/routes/naoRoutes'); //importing route
routes(app); //register the route

app.listen(port);

console.log('Nao RESTful API server started on: ' + port);
