'use strict';

var mongoose = require('mongoose'),
User = mongoose.model('User');

exports.getUserById = function(req, res) {
    const facebookId = req.params.userId;

    User.find({facebookId}, function(err, user) {
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
