import configargparse
import numpy as np
import pandas as pd
import json
import os
import re
import sys

def get_parser():
    parser = configargparse.ArgumentParser(
        description='Transcribe text from speech using a speech recognition model on one CPU or GPU',
        config_file_parser_class=configargparse.YAMLConfigFileParser,
        formatter_class=configargparse.ArgumentDefaultsHelpFormatter)
    parser.add('--feat_dir_name', type=str)
    parser.add('--out_dir_name', type=str)
    parser.add('--feat_file_name', type=str)
    parser.add('--train_file_name', type=str)
    parser.add('--bin_file_name', type=str)

    return parser

def writeNewFeats(newFeats, dir_name, featJsonName):
    with open(dir_name+'/'+featJsonName+'.json' ,'wb') as f:
        f.write(json.dumps({'utts': newFeats}, indent=4, ensure_ascii=False, sort_keys=True).encode('utf-8'))
    
def createBinJson(feat_dir_name, dir_name, feat_file_name="",
        train_file_name="", bin_file_name=""):

    with open(feat_dir_name+'/'+feat_file_name+'.json', 'r') as f:
        orig_feats = json.load(f)['utts']
    with open(feat_dir_name+'/'+bin_file_name+'.json', 'r') as f:
        b = json.load(f)['utts']
    
    seed_n_bin = {**orig_feats, **b}
        
    writeNewFeats(seed_n_bin, dir_name, train_file_name)

def main(args):
    parser = get_parser()
    args = parser.parse_args(args)
    createBinJson(args.feat_dir_name, args.out_dir_name, args.feat_file_name,
            args.train_file_name, args.bin_file_name)

if __name__=='__main__':
    main(sys.argv[1:])
