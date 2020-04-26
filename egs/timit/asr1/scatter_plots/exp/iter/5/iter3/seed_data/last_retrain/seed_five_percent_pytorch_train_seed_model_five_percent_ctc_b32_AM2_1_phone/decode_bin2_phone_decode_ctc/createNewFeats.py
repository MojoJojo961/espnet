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

    b = createDataDict(data)

    with open(feat_dir_name+'/bin1_bin2_n_seed_on_phone.json', 'r') as f:
        orig_feats = json.load(f)['utts']
    
#    orig_feats = {}
    seed_b1 = {**orig_feats, **b}
#    seed_b1_b2 = {**seed_b1, **b}
        
    writeNewFeats(seed_b1, dir_name, 'bin1_bin2P_n_seed_on_phone')
    writeNewFeats(b, dir_name, 'bin2P_on_phone')

createBinJson('.','.')
