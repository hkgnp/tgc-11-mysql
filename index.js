// Import packages
const express = require('express');
const hbs = require('hbs');
const wax = require('wax-on');
const mysql = require('mysql2/promise');

// Set up app
const app = express();
app.set('view engine', 'hbs');
app.use(express.static('public'));
wax.on(hbs.handlebars);
wax.setLayoutPath('./views/layouts');

// Enable forms processing
app.use(
    express.urlencoded({
        extended: false,
    })
);

// Enable handlebars-helpers for pre-built hbs helpers
require("handlebars-helpers") ({handlebars: hbs.handlebars});

// Routes start


app.listen(3000, () => {
    console.log(`Server has started on port 3000`);
});