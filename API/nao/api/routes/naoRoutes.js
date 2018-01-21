'use strict';
module.exports = function(app) {
    var interestPoint = require('../controllers/interestPointController');
    var user = require('../controllers/userController');

    // Interest Points
    app.route('/interestPoint/getAll')
        .get(interestPoint.getAll)
        .post(interestPoint.getAll);

    app.route('/interestPoint/getByCategory')
        .get(interestPoint.getByCategory)
        .post(interestPoint.getByCategory);

    // User
    app.route('/user/getById')
    .get(user.getUserById)
    .post(user.getUserById);

    app.route('/user/addUser')
    .get(user.addUser)
    .post(user.addUser);
};
