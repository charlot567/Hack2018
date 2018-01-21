'use strict';

const yelp = require('yelp-fusion');

const client = yelp.client("7rKKd8VqooaQXD6BBNNXdPM_e3AY-kn5eI0j346KTz1MYP-0pLLNBIknTY_b8SNsKu-oec3OVf6pop0yNz2sX8r89WpYqXWSIbGu4eSIQX5GUg0yHIHBPO6DYpNjWnYx");

client.search({
  categories: 'parks',
  location: 'Montréal, QC'
}).then(response => {
  console.log(response.jsonBody.businesses[0]);
}).catch(e => {
  console.log(e);
});