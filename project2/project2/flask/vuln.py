
from flask import Flask
import botocore
import boto3
import json

app = Flask(__name__)

@app.route('/')
def get_data():
    """
    TODO: Implement code that will return vulnerabilities, as described in the README
    """
    bucket_name = 'delhi-india'
    key = 'example.json'

    s3 = boto3.resource('s3')

    try:
        s3.Bucket(bucket_name).download_file(key,'example.json')
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == "404":
           print("The object does not exist.")
        else:
           raise

    with open("example.json") as d:
        data = json.load(d)
        d.close()

    for x in data.items():
       v = x[1]

#print(v)
    countH = 0
    countL = 0
    countM = 0
#print(type(v))

    for i in range(len(v)):
       if (v[i]['severity'] == 'HIGH'):
          countH= countH + 1
       elif (v[i]['severity'] == 'LOW'):
          countL = countL + 1
       elif (v[i]['severity']) == 'MEDIUM':
          countM += 1

    output = {}
    output['High'] = countH
    output['Low'] = countL
    output['Medium'] = countM
    #print(output) 
    return output  
