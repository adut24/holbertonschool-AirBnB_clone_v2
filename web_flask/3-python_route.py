#!/usr/bin/python3
"""Module defining the message on the /python page"""
from flask import Flask


app = Flask(__name__)


@app.route('/', strict_slashes=False)
def index():
    """return the message for the index"""
    return 'Hello HBNB!'


@app.route('/hbnb', strict_slashes=False)
def hbnb():
    """return the message for /hbnb"""
    return 'HBNB'


@app.route('/c/<text>', strict_slashes=False)
def message_c(text):
    """custom message for c"""
    text = text.replace('_', ' ')
    return 'C {}'.format(text)


@app.route('/python/<text>', strict_slashes=False)
@app.route('/python', strict_slashes=False)
def message_python(text='is cool'):
    """custom message for python"""
    text = text.replace('_', ' ')
    return 'Python {}'.format(text)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
