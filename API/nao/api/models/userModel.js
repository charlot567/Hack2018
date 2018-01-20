'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserSchema = new Schema({
    name: {
        type: String,
    },
    facebookId: {
        type: Number,
    },
    email: {
        type: String,
    }
});

module.exports = mongoose.model('User', UserSchema);
