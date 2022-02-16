from flask import Flask
from flask import request
import requests
#from proxy import vulnerability_proxy
from flask import jsonify 
from vuln import get_data

app = Flask(__name__)

@app.route('/test')
def health_check():
    return "it works"

@app.route('/vulns',methods=['GET']) 
def vulnerability_proxy():
    """
    TODO: Implement get request to backend vulnerability service
    """
    return jsonify(get_data()) 
    pass

@app.route('/evil')
def evil_proxy():
    """
    A function to serve a generic nginx page
    """
    get("http://nginx")

if __name__ == "__main__":
   app.run(host='localhost', port=5000)
