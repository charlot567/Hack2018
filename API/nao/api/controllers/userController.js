'use strict';

var mongoose = require('mongoose'),
User = mongoose.model('User');

exports.getUserById = function(req, res) {
    const userId = req.body.userId;
    User.findOne({"userId": userId}, function(err, user) {
    if (err)
      res.send(err);
    res.json(user);
  });
};

exports.addUser = function(req, res) {
  const new_user = new User(req.body);

  new_user.save(function(err, user) {
    if (err)
      res.send(err);
    res.json(user);
  });
};

exports.addAccomplishedMission = function(req, res) {
  const userId = req.body.userId;
  const missionId = req.body.missionId;
  console.log(missionId);
  User.update({"userId": userId}, {$push:{"missonAccomplished": missionId}}, function(err, user) {
    if (err)
      res.send(err);
      res.json(user);
  });
};

exports.addPoint = function(req, res) {
  const userId = req.body.userId;
  var points = req.body.points;

    User.update({"userId": userId}, {$inc:{"score": points}}, function(err, user) {
      if (err)
        res.send(err);
        else {

          res.json(user);
        }
    });

};
