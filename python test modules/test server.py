from flask import Flask
from flask import jsonify
import json

pin_status = {'switch1':0, 'switch2':0, 'switch3':0, 'gas_leakage':0}

app = Flask(__name__)

@app.route('/')
def index():
    return jsonify(pin_status)

@app.route('/test')
def test():
    return "Test Page"

@app.route('/un/<user>')
def profile(user):
    return "Hey " + user


@app.route('/num/<int:eo>')
def evenodd(eo):
    if(eo % 2 == 0):
        return "Even Number"
    else:
        return "Odd Number"


if __name__ == "__main__":
    app.run(debug=True)