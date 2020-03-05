#!/usr/bin/env python3

import json
import configargparse
import sys
import  os

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

def get_parser():
    parser = configargparse.ArgumentParser(
        description='Transcribe text from speech using a speech recognition model on one CPU or GPU',
        formatter_class=configargparse.ArgumentDefaultsHelpFormatter)
    parser.add('--input_json', type=str)
    parser.add('--output_json', type=str)
    parser.add('--type', type=str)
    parser.add('--output_dir', type=str)

    return parser

def main(args):
    parser = get_parser()
    args = parser.parse_args(args)

    with open(args.input_json, 'r') as f:
        input_json = json.load(f)
        
    with open(args.output_json, 'r') as f:
        output_json = json.load(f)
        
    new_json = dict()
    for key in output_json['utts'].keys():
        new_json[key] = input_json['utts'][key]
        newText = getNewText(output_json['utts'][key]['output'][0]['rec_token'].split(" "))
        new_json[key]['output'][0]['text'] = newText
        new_json[key]['output'][0]['token'] = getNewToken(output_json['utts'][key]['output'][0]['rec_token'].split(" "))
        new_json[key]['output'][0]['tokenid'] = getNewTokenId(output_json['utts'][key]['output'][0]['rec_tokenid'].split(" "))
        new_json[key]['output'][0]['shape'] = [len(newText.split(" ")), 42]
        
    with open(args.output_dir+'/data.json' ,'wb') as f:
        f.write(json.dumps({'utts': new_json}, indent=4, ensure_ascii=False, sort_keys=True).encode('utf-8'))

if __name__=='__main__':
    main(sys.argv[1:])
