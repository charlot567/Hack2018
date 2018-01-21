'use strict';

var mongoose = require('mongoose'),
DidYouKnow = mongoose.model('DidYouKnow');

exports.getAll = function(req, res) {
  DidYouKnow.find({}, function(err, fact) {
    if (err)
      res.send(err);
    res.json(fact);
  });
};

exports.getByLang = function(req, res) {
  const lang = req.body.lang;

  DidYouKnow.find({"lang": lang}, function(err, fact) {
    if (err)
      res.send(err);
    res.json(fact);
  });
};

exports.add = function(req, res) {
  const new_data = new DidYouKnow(req.body);

  new_data.save(function(err, data) {
    if (err)
      res.send(err);
    res.json(data);
  });
};
