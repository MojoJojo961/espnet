#!/usr/bin/env python3

import configargparse
import json
import re
import csv
import sys

def get_parser():
    parser = configargparse.ArgumentParser(
        description='Transcribe text from speech using a speech recognition model on one CPU or GPU',
        config_file_parser_class=configargparse.YAMLConfigFileParser,
        formatter_class=configargparse.ArgumentDefaultsHelpFormatter)
    parser.add('--plot_dir', type=str)

    return parser

def main(args):
    parser = get_parser()
    args = parser.parse_args(args)
    
    with open(args.plot_dir+'/mergedDataJson.json' ,'r') as f:
        data = (json.load(f))['utts']
        score_list = [[k, data[k]['output'][0]['score_norm_on_frame']]  for k, v in sorted(data.items())]
        """for key, value in sorted(data.items()):
            tmp = data[key]
            score = tmp['output'][0]['score']
            frame_size = tmp['input'][0]['shape'][0]
            score_norm = score / frame_size
            score_list.append([key, score_norm])
            #break
        #print(score_list)
        """

    with open(args.plot_dir+'/confidence_score.csv', 'w') as f:
        writer = csv.writer(f)
        writer.writerows(score_list)

if __name__ == '__main__':
    main(sys.argv[1:])
