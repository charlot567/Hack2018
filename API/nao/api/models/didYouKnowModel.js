'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var DidYouKnowSchema = new Schema({
    description: {
        type: String,
    },
    lang: {
        type: String,
    }
});

module.exports = mongoose.model('DidYouKnow', DidYouKnowSchema);
