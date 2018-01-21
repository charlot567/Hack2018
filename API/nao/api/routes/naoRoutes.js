'use strict';
module.exports = function(app) {
    var interestPoint = require('../controllers/interestPointController');
    var user = require('../controllers/userController');
    var didYouKnow = require('../controllers/didYouKnowController');

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

    app.route('/didYouKnow/getAll')
    .post(didYouKnow.getAll);

    app.route('/didYouKnow/getByLang')
    .post(didYouKnow.getByLang);

    app.route('/didYouKnow/add')
    .post(didYouKnow.add);
};
