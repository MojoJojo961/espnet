#!/bin/bash

export PATH=$PATH:$PWD/pkg
export PYTHONIOENCODING=UTF-8

expdir=
rtask=
recog_set=
dir=
feat_dir=
input_json=data.json
output_json=data.json

. utils/parse_options.sh || exit 1;

scatterplotdir=scatter_plots/${dir}
if [ ! -e ${scatterplotdir} ]; then
	mkdir -p ${scatterplotdir}
fi

if [ -e ${dir}/ref.trn ] && [ -e ${dir}/hyp.trn ]; then
	echo "Stage 1: creating a WER from uttid csv file"
	~/kaldi/tools/sctk/bin/sclite -r ${dir}/ref.trn -h ${dir}/hyp.trn -i rm -C det -o snt stdout > ${scatterplotdir}/result2.txt

	cat ${scatterplotdir}/result2.txt | grep "id:" | cut -d ' ' -f2- | sed -e 's/[()]//g' | cut -d '-' -f2- | tr '[:lower:]' '[:upper:]' > ${scatterplotdir}/uttids

	cat ${scatterplotdir}/result2.txt | grep "Errors" | cut -d '=' -f2- | tr -s " " | awk '{print $1}' | sed -e 's/\%//g' > ${scatterplotdir}/WERs

	paste -d ',' ${scatterplotdir}/uttids ${scatterplotdir}/WERs > ${scatterplotdir}/uttid2wer.csv
	rm -f result2.txt uttids WERs
	
	echo "Stage 2: creating a json file from input and output data.json"
	merge2Json.py --input_json ${feat_dir}/${input_json} \
		--output_json ${dir}/${output_json} \
		--plot_dir ${scatterplotdir}
	
	echo "Stage 3: get confidence score"
	getConfidenceScore.py --plot_dir ${scatterplotdir}
	
	echo "Stage 4: create scatter plot"
	createScatterPlot.py --plot_dir ${scatterplotdir} \
		--dir_name ${dir}
fi
