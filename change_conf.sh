#!/bin/bash

. ./path.sh || exit 1;

epoch=100
batch=10

. utils/parse_options.sh || exit 1;

#change_yaml.py conf/train.yaml -a epochs=${epoch}
#change_yaml.py conf/train.yaml -a batch-size=${batch}
change_yaml.py conf/train_batch-size32.yaml -a epochs=${epoch}

conda deactivate
