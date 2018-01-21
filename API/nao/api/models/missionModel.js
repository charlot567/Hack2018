'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var MissionSchema = new Schema({
    reward: {
        type: Number,
    },
    position: {
        lat: Number,
        long: Number,
    },
    description: {
        type: String,
    },
    question: {
        question: String,
        answer: Array,
        correctAnswerIndex: Number,
    },

});

module.exports = mongoose.model('Mission', MissionSchema);
