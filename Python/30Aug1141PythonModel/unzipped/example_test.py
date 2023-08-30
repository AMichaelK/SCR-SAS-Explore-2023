import os
import os.path
import sys

sys.path.append('/models/resources/viya/62c6c111-0c77-4bbc-a7c0-f6f40cf959c6/')

import hmeq_logistic_score

import settings_62c6c111_0c77_4bbc_a7c0_f6f40cf959c6

settings_62c6c111_0c77_4bbc_a7c0_f6f40cf959c6.pickle_path = '/models/resources/viya/62c6c111-0c77-4bbc-a7c0-f6f40cf959c6/'

def score_record(JOB,REASON,CLAGE,CLNO,DEBTINC,DELINQ,DEROG,NINQ,YOJ):
    "Output: EM_EVENTPROBABILITY,EM_CLASSIFICATION"
    return hmeq_logistic_score.scoreHMEQLogisticModel(JOB,REASON,CLAGE,CLNO,DEBTINC,DELINQ,DEROG,NINQ,YOJ)

print(score_record("","",143.88,46.15,16.94,28.84,32.97,78.45,22.30))
