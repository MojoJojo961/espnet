#!/usr/bin/env python3

import configargparse
import json
import sys

"""with open('../../../../dump/test/deltafalse/data.json', 'r') as f:
    input_data_json = json.load(f)['utts']

with open('../data.json', 'r') as f:
    output_data_json = (json.load(f))['utts']

if len(input_data_json.keys()) == len(output_data_json.keys()):
    for key,value in sorted(output_data_json.items()):
        #print(key)
        #print(value)
        #print(input_data_json[key]['input'])
        output_data_json[key]['input'] = input_data_json[key]['input']
        #print(output_data_json[key])
        #break

with open('mergedDataJson.json' ,'wb') as f:
    f.write(json.dumps({'utts': output_data_json}, indent=4, ensure_ascii=False, sort_keys=True).encode('utf-8'))
"""

def get_parser():
    """Get default arguments."""
    parser = configargparse.ArgumentParser(
            config_file_parser_class=configargparse.YAMLConfigFileParser,
            formatter_class=configargparse.ArgumentDefaultsHelpFormatter)
    parser.add('--input_json', type=str)
    parser.add('--output_json', type=str)
    parser.add('--plot_dir', type=str)

    return parser

def main(args):
    parser = get_parser()
    args = parser.parse_args(args)
    
    with open(args.input_json, 'r') as f:
        input_data_json = json.load(f)['utts']
    
    with open(args.output_json, 'r') as f:
        output_data_json = (json.load(f))['utts']
        
    if len(input_data_json.keys()) == len(output_data_json.keys()):
        for key,value in sorted(output_data_json.items()):
            output_data_json[key]['input'] = input_data_json[key]['input']
            
    with open(args.plot_dir+'/mergedDataJson.json' ,'wb') as f:
        f.write(json.dumps({'utts': output_data_json}, indent=4, ensure_ascii=False, sort_keys=True).encode('utf-8'))

if __name__ == '__main__':
    main(sys.argv[1:])
