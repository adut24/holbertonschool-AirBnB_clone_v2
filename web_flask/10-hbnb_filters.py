#!/usr/bin/python3
"""Module for the different pages with Flask"""
from flask import Flask, render_template
from models import storage
from models.state import State
from models.amenity import Amenity


app = Flask(__name__)
app.jinja_env.trim_blocks = True
app.jinja_env.lstrip_blocks = True


@app.teardown_appcontext
def close(exception):
    """Close storage"""
    storage.close()


@app.route('/hbnb_filters', strict_slashes=False)
def hbnb_filters():
    """Show hbnb static"""
    return render_template('10-hbnb_filters.html', states=storage.all(State),
                           amenities=storage.all(Amenity))


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
