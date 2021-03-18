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
require("handlebars-helpers")({ handlebars: hbs.handlebars });

// Routes start
(async () => {
    // Create an SQL connection
    let connection = await mysql.createConnection({
        'host': 'localhost',
        'user': 'root',
        'database': 'sakila'
    })

    // Test query
    // let query = "SELECT * FROM actors";
    // let [actors] = await connection.execute("SELECT * from actor")

    // for (let a of actors) {
    //     console.log(a)
    // }

    app.get('/actors', async (req, res) => {
        const [actors] = await connection.execute("SELECT * from actor")
        res.render('actors', {
            'actors': actors
        })
    })

    app.get('/actors/create', async (req, res) => {
        res.render('actor_create')
    })

    app.post('/actors/create', async (req, res) => {
        const { first_name, last_name } = req.body;
        const query = `insert into actor (first_name, last_name) VALUES (?, ?)`;

        // Prevents SQL Injection
        await connection.execute(query, [first_name, last_name]);
        res.redirect('/actors');
    })

    app.get('/actors/:actor_id/update', async (req, res) => {
        const query = "SELECT * from actor WHERE actor_id = ?";
        const [actors] = await connection.execute(query, [req.params.actor_id]);
        const actor = actors[0]

        res.render('actor_update', {
            'actor': actor
        })
    })

    app.post('/actors/:actor_id/update', async (req, res) => {
        const { first_name, last_name } = req.body;
        const query = "UPDATE actor SET first_name=?,last_name=? WHERE actor_id=?";

        await connection.execute(query, [first_name, last_name, req.params.actor_id]);
        res.redirect('/actors')
    })

    app.get('/actors/:actor_id/delete', async (req, res) => {
        const query = "SELECT * from actor WHERE actor_id = ?";
        const [actors] = await connection.execute(query, [req.params.actor_id]);
        const actor = actors[0];

        res.render('actor_delete', {
            'actor': actor
        })
    })

    app.post('/actors/:actor_id/delete', async (req, res) => {
        const query = "DELETE FROM actor WHERE actor_id = ?";
        await connection.execute(query, [req.params.actor_id]);
        res.redirect('/actors');
    })

    app.get('/films/create', async (req, res) => {
        const [languages] = await connection.execute("SELECT * FROM language");
        const [actors] = await connection.execute("SELECT * FROM actor");

        res.render('film_create', {
            'languages': languages,
            'actors': actors
        })
    })

    app.post('/films/create', async (req, res) => {
        const { title, description, release_year, original_language_id, language_id, rental_duration, rental_rate, length, replacement_cost } = req.body;
        const query = "INSERT INTO film (title, description, release_year, original_language_id, language_id, rental_duration, rental_rate, length, replacement_cost) VALUES (?,?,?,?,?,?,?,?,?)"

        await connection.execute(query, [
            title, description, release_year, original_language_id, language_id, rental_duration, rental_rate, length, replacement_cost
        ])

        res.send("New film has been added.");

    })

    app.get('/films/:film_id/update', async (req, res) => {
        const query = "SELECT * FROM film where film_id = ?";
        const [films] = await connection.execute(query, [req.params.film_id]);
        const film = films[0];
        const [languages] = await connection.execute("SELECT * FROM language");

        res.render('film_update', {
            'film': film,
            'languages': languages
        })
    })

    app.post('/films/:film_id/update', async (req, res) => {
        const { title, description, release_year, original_language_id, language_id, rental_duration, rental_rate, length, replacement_cost } = req.body;
        const query = `UPDATE film
            SET title=?, description=?, release_year=?, original_language_id=?, 
            language_id=?, rental_duration=?, rental_rate=?,
            length=?, replacement_cost=? WHERE film_id = ?`;

        await connection.execute(query, [
            title, description, release_year, original_language_id, language_id, rental_duration, rental_rate, length, replacement_cost, req.params.film_id
        ])

        res.send("Film has been updated.");
    })
})();

app.listen(3000, () => {
    console.log(`Server has started on port 3000`);
});