import requests as rq

data = rq.get('https://data.seattle.gov/resource/4fs7-3vj5.json')

print(data.json())