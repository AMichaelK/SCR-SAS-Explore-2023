import os
import os.path
import sys

sys.path.append('/models/resources/viya/5b2981f2-4814-48cb-825a-463d76801b2c/')

import score_Xgboost

import settings_5b2981f2_4814_48cb_825a_463d76801b2c

settings_5b2981f2_4814_48cb_825a_463d76801b2c.pickle_path = '/models/resources/viya/5b2981f2-4814-48cb-825a-463d76801b2c/'

def score_record(Carrier,DayofMonth,OriginAirport,ScheduledElapsedTimeMinutes,ArrivalHour,DepatureHour):
    "Output: EM_CLASSIFICATION,EM_EVENTPROBABILITY"
    return score_Xgboost.score(Carrier,DayofMonth,OriginAirport,ScheduledElapsedTimeMinutes,ArrivalHour,DepatureHour)

print(score_record("",97.60,"",142.20,26.75,108.79))
