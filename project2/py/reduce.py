# https://www.accelebrate.com/blog/using-defaultdict-python

import json                                                                   
from collections import defaultdict
import pprint
                                                                                           
with open('example.json') as f:                                                               
  data = json.load(f)                                                                      
                                                                                           
vulncalc = defaultdict(lambda: { "HIGH":0, "MEDIUM":0, "LOW":0 })                 
for vendor in data['vulnerabilities']:                                                        
    vulncalc[vendor['vendor_id']][vendor['severity']] += 1                                             

pprint.pprint(vulncalc)
