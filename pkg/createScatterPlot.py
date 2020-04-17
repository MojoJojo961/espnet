#!/usr/bin/env python3

import configargparse
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os 
import sys
import re
import seaborn as sns

def get_parser():
    parser = configargparse.ArgumentParser(
        description='Transcribe text from speech using a speech recognition model on one CPU or GPU',
        config_file_parser_class=configargparse.YAMLConfigFileParser,
        formatter_class=configargparse.ArgumentDefaultsHelpFormatter)    
    parser.add('--plot_dir', type=str)
    parser.add('--dir_name', type=str)

    return parser

def readAndMergeCSV(args):
    per = pd.read_csv(args.plot_dir+'/uttid2wer.csv', names=['uttid', 'per'])
    #print(per.head())
    
    score = pd.read_csv(args.plot_dir+'/confidence_score.csv', names=['uttid', 'score'])
    #print(score.head())
    
    df = pd.merge(per, score, how='left', on=['uttid'])
    #print(df.head())
    return df

def getPlotName(dir_name):
    plot_name = ""
    try:
        exp_name = re.search('_pytorch_train(.+?)\/decode', dir_name)
        if exp_name:
            exp_name = exp_name.group(1)
        else:
            exp_name = ""
        task_name = re.search('\/decode(.+?)_decode', dir_name)
        if task_name:
            task_name = task_name.group(1)
        else:
            task_name = ""
        if exp_name.startswith("_"):
            exp_name = exp_name[1:] + "_"
        if task_name.startswith("_"):
            task_name = task_name[1:] + "_"
        plot_name = exp_name + task_name
    except:
        plot_name = ""
    return plot_name

def plot(dataframe, args):
    g = sns.jointplot(x=dataframe.score, y=dataframe.per, space=0)
    g = g.plot_joint(sns.regplot)
    g = g.set_axis_labels('Confidence Measure', 'PER')
    g.savefig(args.plot_dir+'/scatter_'+getPlotName(args.dir_name)+'frame_norm.png')

def main(args):
    parser = get_parser()
    args = parser.parse_args(args)
    
    df = readAndMergeCSV(args)
    plot(df, args)

if __name__=='__main__':
    main(sys.argv[1:])
