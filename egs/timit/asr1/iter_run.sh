exp="seed_five_percent"
exp_name="seed_model_five_percent"
model_no="AM1_1_phone"
model="${exp}_pytorch_train_${exp_name}_ctc_b32_${model_no}"
bin=bin1
bin_no=1
recog_bin_dir=bin1_phone
prev_epoch=200
for i in 2 3 4; do
    tag="train_${exp_name}_ctc_b32_${model_no::-8}_${i}_phone"
    new_epoch=$(($prev_epoch + 100))
    train_conf="./conf/train_batch-size32_epochs${new_epoch}.yaml"
    
    feat_file="${bin}P2_n_seed_on_phone"
    
    ./run_seed_bin.sh --ngpu 1 --timit /home/sumit/TIMIT --trans_type phn --stage 3 --tag ${tag} --train_config ${train_conf} --decode_config ./conf/decode_ctc.yaml --verbose 2 --train_set seed_five_percent --recog_model model.loss.best --train_data ${feat_file}.json --recog_set "test ${recog_bin_dir}" --resume exp/${model}/results/snapshot.ep.${prev_epoch}

    #echo ${tag}
    #echo ${train_conf}
    #echo ${model}
    #echo ${prev_epoch}
    #echo ${new_epoch}
    
    prev_epoch=${new_epoch}

    cd scatter_plots/exp/ 
    feat_dir=${model}/decode_${recog_bin_dir}_decode_ctc
    out_dir=${exp}_pytorch_${tag}/decode_${recog_bin_dir}_decode_ctc

    train_file="${bin}P${i}_n_seed_on_phone"
    recog_file="${bin}P${i}_on_phone"

    # Activate conda environment
    source ~/miniconda2/etc/profile.d/conda.sh
    conda activate sumit

    # Update decoded bin feats
    python updateFeats.py --feat_dir_name ${feat_dir} \
	  --out_dir_name ${out_dir} \
	  --feat_file_name ${feat_file} \
	  --train_file_name ${train_file} \
	  --recog_file_name ${recog_file}

    # Deactivate conda
    conda deactivate

    # Copy feats to dir
    cp ${out_dir}/${train_file}.json ../../dump/${exp}/deltafalse/.
    cp ${out_dir}/${recog_file}.json ../../dump/${recog_bin_dir}/deltafalse/.

    # Rename bin feats
    mv ../../dump/${recog_bin_dir}/deltafalse/${recog_file}.json ../../dump/${recog_bin_dir}/deltafalse/data.json

    model=${exp}_pytorch_${tag}
    feat_file=${train_file}
    cd ../..

done
