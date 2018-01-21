'use strict';

var mongoose = require('mongoose'),
  InterestPoint = mongoose.model('InterestPoint');

exports.getAll = function(req, res) {
    InterestPoint.find({}, function(err, point) {
    if (err)
      res.send(err);
    res.json(point);
  });
};

exports.getByCategory = function(req, res) {
    const category = req.query.category || req.body.category;
    InterestPoint.find({category}, function(err, point) {
    if (err)
      res.send(err);
    res.json(point);
  });
};

exports.addInterestPoint = function(req, res) {
    const new_interestPoint = new InterestPoint(req.body);

    new_interestPoint.save(function(err, point) {
    if (err)
        res.send(err);
    res.json(point);
  });
};
