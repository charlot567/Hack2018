'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var InterestPointSchema = new Schema({
    name: {
        type: String,
    },
    description: {
        type: String,
    },
    imageUrl: {
        type: String
    },
    moreInfoUrl: {
        type: String,
    },
    category: {
        type: String,
        default: "Other"
    },
    rating: {
        yelp: Number,
        google: Number,
        facebook: Number
    },
    position: {
        lat: Number,
        long: Number
    },
    free: {
        type: Boolean,
        default: true
    },
    location: {
        address1: String,
        address2: String,
        address3: String,
        city: String,
        zip_code: String,
        country: String,
        state: String,
        display_address: Array,
    }
});

module.exports = mongoose.model('InterestPoint', InterestPointSchema);
