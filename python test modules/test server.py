from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return "This is homepage"

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