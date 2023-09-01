import requests
import json

host = 'localhost'
port = '9100'

csvData = \
 '"Carrier","DayofMonth","OriginAirport","ScheduledElapsedTime","ArrivalHour","DepatureHour"\r' + \
 '"American Airlines", 11 , "ORD", 181, 10,  8\r' + \
 '"Delta Airlines", 11 , "LAX", 80, 14,  13'

multipart_form_data = {'file': csvData}

# Execution
url = 'http://' + host + ':' + port + '/executions'
print('Scoring Endpoint: ', url)
r = requests.post(url, files=multipart_form_data)
print(r.json())
executionId = r.json()['id']

# Output
url= 'http://' + host + ':' + port + '/query/'
r1 = requests.get(url + executionId)
print('\nOutput:\n', r1.text)

# # logs
# r2 = requests.get(url + executionId + '/log')
# print('Log:', r2.text)

# # Container logs
# r3 = requests.get('http://' + host + ':' + port + '/system/log')
# print('Log2:', r3.text)
