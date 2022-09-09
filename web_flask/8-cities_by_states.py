#!/usr/bin/python3
"""Module for the different pages with Flask"""
from flask import Flask, render_template
from models import storage
from models.state import State


app = Flask(__name__)
app.jinja_env.trim_blocks = True
app.jinja_env.lstrip_blocks = True


@app.teardown_appcontext
def close(exception):
    """Close storage"""
    storage.close()


@app.route('/cities_by_states', strict_slashes=False)
def cities_states():
    """List all cities by states"""
    return render_template('8-cities_by_states.html',
                           states=storage.all(State))


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
