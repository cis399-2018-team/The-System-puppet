from flask import Flask
from flask import render_template
from flask import request
from flask import url_for
from flask import redirect
import pymongo
from pymongo import MongoClient
client = MongoClient()
db = client.bad_results_db
collection = db.bad_results_collection

app = Flask(__name__)

@app.route("/")
@app.route("/index")
def index():
    return render_template('index.html')

@app.route("/image")
def image():
        return render_template('image.html')

@app.route("/results", methods=['POST'])
def results():
	label = request.form.get('label')
	prob = request.form.get('probability')
	result = {"label": label,
		"probability":prob}
	collection.insert(result)
	return redirect(url_for('image'))

if __name__ == '__main__':
	app.run()

