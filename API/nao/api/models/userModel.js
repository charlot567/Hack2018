'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserSchema = new Schema({
    name: {
        type: String,
    },
    userId: {
        type: String,
    },
    email: {
        type: String,
    },
    lang: {
        type: String,
    },
    score:{
        type: String,
    }
});

module.exports = mongoose.model('User', UserSchema);
