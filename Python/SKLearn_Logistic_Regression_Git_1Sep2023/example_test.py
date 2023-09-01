import os
import os.path
import sys

sys.path.append('/models/resources/viya/e4949fbb-1dfb-43f7-92b3-442f8b968dc7/')

import score_SKLearn_Logistic_Regression

import settings_e4949fbb_1dfb_43f7_92b3_442f8b968dc7

settings_e4949fbb_1dfb_43f7_92b3_442f8b968dc7.pickle_path = '/models/resources/viya/e4949fbb-1dfb-43f7-92b3-442f8b968dc7/'

def score_record(Carrier,DayofMonth,OriginAirport,ScheduledElapsedTimeMinutes,ArrivalHour,DepatureHour):
    "Output: EM_CLASSIFICATION,EM_EVENTPROBABILITY"
    return score_SKLearn_Logistic_Regression.score(Carrier,DayofMonth,OriginAirport,ScheduledElapsedTimeMinutes,ArrivalHour,DepatureHour)

print(score_record("",41.90,"",2.80,103.55,119.64))
