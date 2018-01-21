'use strict';

var mongoose = require('mongoose'),
Mission = mongoose.model('Mission');

exports.getAll = function(req, res) {
  Mission.find({}, function(err, mission) {
    if (err)
      res.send(err);
    res.json(mission);
  });
};

exports.getByLang = function(req, res) {
  const lang = req.body.lang;

  Mission.find({"lang": lang}, function(err, mission) {
    if (err)
      res.send(err);
    res.json(mission);
  });
};

exports.add = function(req, res) {
  const new_data = new Mission(req.body);

  new_data.save(function(err, data) {
    if (err)
      res.send(err);
    res.json(data);
  });
};
