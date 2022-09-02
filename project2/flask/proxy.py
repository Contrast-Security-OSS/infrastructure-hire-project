from flask import Flask
from requests import get

app = Flask(__name__)

@app.route('/test')
def health_check():
    return "it works"

@app.route('/vulns')
def vulnerability_proxy():
    """
    TODO: Implement get request to backend vulnerability service
    """
    pass

@app.route('/evil')
def evil_proxy():
    """
    A function to serve a generic nginx page
    """
    get("http://nginx")
