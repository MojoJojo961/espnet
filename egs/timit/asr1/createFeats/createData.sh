#!/bin/bash

export PATH=$PATH:$PWD/dataCreation
export PYTHONIOENCODING=UTF-8

input_json=
output_json=
output_dir=

. utils/parse_options.sh || exit 1;

createDataForSeedPrimeModel.py \
	--input_json ${input_json} \
	--output_json ${output_json}\
	--type train \
	--output_dir ${output_dir}
