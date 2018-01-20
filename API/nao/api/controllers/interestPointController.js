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
    const {category} = req.params;
    InterestPoint.find({category}, function(err, point) {
    if (err)
      res.send(err);
    res.json(point);
  });
};

exports.addInterestPoint = function(req, res) {
    const new_interestPoint = new InterestPoint(req.body);
    console.log(new_interestPoint);
   /* new_interestPoint.save(function(err, point) {
    if (err)
        res.send(err);
    res.json(point);
  });*/
};
