'use strict';

exports.fetchData = function() {
  const yelp = require('yelp-fusion');
  const InterestPoint = require("./api/models/interestPointModel");

  const client = yelp.client("7rKKd8VqooaQXD6BBNNXdPM_e3AY-kn5eI0j346KTz1MYP-0pLLNBIknTY_b8SNsKu-oec3OVf6pop0yNz2sX8r89WpYqXWSIbGu4eSIQX5GUg0yHIHBPO6DYpNjWnYx");
  const category ='parks'
  client.search({
    categories: category,
    location: 'Montréal, QC'
  }).then(response => {
    //console.log(response.jsonBody.businesses);
    response.jsonBody.businesses.map((businesse) => {
        console.log(businesse);
        const point = InterestPoint(businesse);
        point.imageUrl = businesse.image_url;
        point.category = category;
        point.rating.yelp = businesse.rating;
        point.position.lat = businesse.coordinates.latitude;
        point.position.long = businesse.coordinates.longitude;
        //console.log(point);
    });
  }).catch(e => {
    console.log(e);
  });
}
