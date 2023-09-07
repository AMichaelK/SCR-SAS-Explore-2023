import requests
import json

host = 'localhost'
port = '9100'

csvData = \
 '"REASON","JOB","YOJ","DEROG","DELINQ","CLAGE","NINQ","CLNO","DEBTINC","MORTDUE","LOAN","VALUE"\r' + \
 '"HomeImp", "Other" , 3, 0, 2, 65.8,  1,  2, 50, 1000, 2000, 500000\r' + \
 '"HomeImp", "Sales" , 6, 0, 2, 32.5,  4,  4, 20, 10000, 20000, 40000\r' + \
 '"HomeImp", "Office", 5, 0, 2, 121.1, 2,  8, 13, 30000, 60000, 80000\r' + \
 '"HomeImp", "Other" , 2, 0, 2, 221.2, 6, 14, 10, 90000, 170000, 222003'
    
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
