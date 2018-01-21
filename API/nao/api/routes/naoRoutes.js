'use strict';
module.exports = function(app) {
    var interestPoint = require('../controllers/interestPointController');
    var user = require('../controllers/userController');
    var didYouKnow = require('../controllers/didYouKnowController');
    var mission = require('../controllers/missionController');

    // Interest Points
    app.route('/interestPoint/getAll')
        .post(interestPoint.getAll);

    app.route('/interestPoint/getByCategory')
        .post(interestPoint.getByCategory);

    // User
    app.route('/user/getById')
    .post(user.getUserById);

    app.route('/user/addUser')
    .post(user.addUser);

    app.route('/user/addAccomplishedMission')
    .post(user.addAccomplishedMission);

    app.route('/user/addPoint')
    .post(user.addPoint);

    app.route('/didYouKnow/getAll')
    .post(didYouKnow.getAll);

    app.route('/didYouKnow/getByLang')
    .post(didYouKnow.getByLang);

    app.route('/didYouKnow/add')
    .post(didYouKnow.add);

    app.route('/mission/getAll')
    .post(mission.getAll);

    app.route('/mission/getByLang')
    .post(mission.getByLang);

    app.route('/mission/add')
    .post(mission.add);
};
