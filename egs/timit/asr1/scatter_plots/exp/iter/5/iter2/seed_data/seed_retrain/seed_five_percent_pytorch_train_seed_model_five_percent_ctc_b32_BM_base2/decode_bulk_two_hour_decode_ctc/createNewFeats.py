import numpy as np
import pandas as pd
import json
import os
import re

def getNewText(oldText):
    newText = []
    for token in oldText:
        if token=='<space>':
            newText.append('sil')
        elif token=='<eos>':
            continue
        else:
            newText.append(token)
    return ' '.join(newText)

def getNewToken(oldToken):
    return ' '.join(oldToken[:len(oldToken)-1])

def getNewTokenId(oldTokenId):
    return ' '.join(oldTokenId[:len(oldTokenId)-1])

def sortBin(bin_data, sort_on='score_norm_on_phone'):
    tdd = bin_data
    return {k: v for k, v in sorted(tdd.items(), key=lambda item: (item[1]['output'][0][sort_on], item[0]), reverse=True)}

def createDataDict(bin_data):
    new_json = dict()
    for key in bin_data.keys():
        new_json[key] = {}
        new_json[key]['input'] = bin_data[key]['input']
        newText = getNewText(bin_data[key]['output'][0]['rec_token'].split(" "))
        new_json[key]['utt2spk'] = re.search('(.+?)_', key).group(1)
        new_json[key]['output'] = [{}]
        new_json[key]['output'][0]['name'] = 'target1'
        new_json[key]['output'][0]['text'] = newText
        new_json[key]['output'][0]['token'] = getNewToken(bin_data[key]['output'][0]['rec_token'].split(" "))
        new_json[key]['output'][0]['tokenid'] = getNewTokenId(bin_data[key]['output'][0]['rec_tokenid'].split(" "))
        new_json[key]['output'][0]['shape'] = [len(newText.split(" ")), 42]
    return new_json
    
def writeNewFeats(newFeats, dir_name, featJsonName):
    with open(dir_name+'/'+featJsonName+'.json' ,'wb') as f:
        f.write(json.dumps({'utts': newFeats}, indent=4, ensure_ascii=False, sort_keys=True).encode('utf-8'))
    
def createBinJson(feat_dir_name, dir_name):
    with open(dir_name+'/mergedDataJson.json' ,'r') as f:
        data = (json.load(f))['utts']

    sort_on = 'score_norm_on_phone'
    #sort data
    tmp = {k: v for k, v in sorted(data.items(), key=lambda item: (item[1]['output'][0][sort_on], item[0]), reverse=False)}

    #bin data
    score_list = [[k, data[k]['output'][0][sort_on]]  for k, v in sorted(data.items())]
    score = pd.DataFrame(score_list, columns=['uttid', 'score'])
    count, _ = np.histogram(score['score'], bins=5)

    B = []
    p = 0
    for i in count:
        n = p + i
        #print(p, n)
        B.append(dict(list(tmp.items())[p:n]))
        p = n
    B.reverse()

    #take bin1 and write in json
    #tdd = B[0]
    #tdd = {k: v for k, v in sorted(tdd.items(), key=lambda item: (item[1]['output'][0][sort_on], item[0]), reverse=True)}
    b = [None] * 5
    b[0] = createDataDict(sortBin(B[0], sort_on))
    b[1] = createDataDict(sortBin(B[1], sort_on))
    b[2] = createDataDict(sortBin(B[2], sort_on))
    b[3] = createDataDict(sortBin(B[3], sort_on))
    b[4] = createDataDict(sortBin(B[4], sort_on))
    
    with open(feat_dir_name+'/data.json', 'r') as f:
        orig_feats = json.load(f)['utts']
    
#    orig_feats = {}
    seed_b1 = {**orig_feats, **b[0]}
    seed_b1_b2 = {**seed_b1, **b[1]}
    seed_b1_b2_b3 = {**seed_b1_b2, **b[2]}
    seed_b1_b2_b3_b4 = {**seed_b1_b2_b3, **b[3]}
    seed_b1_b2_b3_b4_b5 = {**seed_b1_b2_b3_b4, **b[4]}
        
#     with open(dir_name+'/bin1.json' ,'wb') as f:
#         f.write(json.dumps({'utts': new_feats}, indent=4, ensure_ascii=False, sort_keys=True).encode('utf-8'))
    writeNewFeats(seed_b1, dir_name, 'bin1_n_seed_on_phone_from_seed_retrain')
    writeNewFeats(seed_b1_b2, dir_name, 'bin1_bin2_n_seed_on_phone_from_seed_retrain')
    writeNewFeats(seed_b1_b2_b3, dir_name, 'bin1_bin2_bin3_n_seed_on_phone_from_seed_retrain')
    writeNewFeats(seed_b1_b2_b3_b4, dir_name, 'bin1_bin2_bin3_bin4_n_seed_on_phone_from_seed_retrain')
    writeNewFeats(seed_b1_b2_b3_b4_b5, dir_name, 'bin1_bin2_bin3_bin4_bin5_n_seed_on_phone_from_seed_retrain')

createBinJson('.','.')
