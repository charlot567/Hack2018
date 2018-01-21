'use strict';

var mongoose = require('mongoose'),
Mission = mongoose.model('Mission');
User = mongoose.model('User');

exports.getAll = function(req, res) {
  const userId = req.body.userId;
  var missonAccomplished = [];
  console.log("get all mission: " + userId)
  User.findOne({"userId": userId}, function(err, _user) {
    if (err)
      res.send(err);
      if(_user){
        missonAccomplished = _user.missonAccomplished;
        console.log(missonAccomplished);

        Mission.find({}, function(err, mission) {
          if (err)
            res.send(err);
        
          console.log(mission);

          mission.map((m)=>{
            if(~missonAccomplished.indexOf(`${m._id}`)){
              m.accomplished = true;
            }
          });
          
          res.json(mission);
        });
      }
  });
};

exports.getByLang = function(req, res) {
  const lang = req.body.lang;
  const userId = req.body.userId;
  var missonAccomplished = [];

  User.findOne({"userId": userId}, function(err, _user) {
    if (err)
      res.send(err);
      if(_user){
        missonAccomplished = _user.missonAccomplished;
      }
  });
  Mission.find({"lang": lang}, function(err, mission) {
    if (err)
      res.send(err);

      mission.map((m)=>{
        if(~missonAccomplished.indexOf(`${m._id}`)){
          m.accomplished = true;
        }
      });

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
