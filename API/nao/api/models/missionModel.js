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
    title: {
        type: String,
    },
    description: {
        type: String,
    },
    question: {
        question: String,
        answers: Array,
        correctAnswerIndex: Number,
    },
    postQuestion: {
        correct: String,
        wrong: String,
    },
    lang: {
        type: String,
    },
    accomplished: {
        type: Boolean,
        default: false
    }

});

module.exports = mongoose.model('Mission', MissionSchema);
