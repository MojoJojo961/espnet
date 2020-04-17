#CUDA_VISIBLE_DEVICES=0 ./run_seed.sh --ngpu 1 --timit /home/sumit/TIMIT --trans_type phn --stage 3 --tag "train_ground_truth_model_for_five_percent_ctc_b32" --train_config ./conf/train_batch-size32_epochs100.yaml --decode_config ./conf/decode_ctc.yaml --verbose 2 --train_set seed_five_n_unlabel --recog_model model.loss.best

#CUDA_VISIBLE_DEVICES=0 ./run_seed.sh --ngpu 1 --timit /home/sumit/TIMIT --trans_type phn --stage 3 --tag "train_seed_model_five_percent_ctc_b32" --train_config ./conf/train_batch-size32_epochs100.yaml --decode_config ./conf/decode_ctc.yaml --verbose 2 --train_set seed_five_percent --recog_model model.loss.best

CUDA_VISIBLE_DEVICES=0 ./run_seed_bin.sh --ngpu 1 --timit /home/sumit/TIMIT --trans_type phn --stage 3 --tag "train_seed_model_five_percent_ctc_b32_with_B1_phone" --train_config ./conf/train_batch-size32_epochs200.yaml --decode_config ./conf/decode_ctc.yaml --verbose 2 --resume exp/seed_five_percent_pytorch_train_seed_model_five_percent_ctc_b32/results/snapshot.ep.100 --train_set seed_five_percent --recog_model model.loss.best --train_data bin1_on_phone.json 

CUDA_VISIBLE_DEVICES=0 ./run_seed_bin.sh --ngpu 1 --timit /home/sumit/TIMIT --trans_type phn --stage 3 --tag "train_seed_model_five_percent_ctc_b32_with_B1_2_phone" --train_config ./conf/train_batch-size32_epochs200.yaml --decode_config ./conf/decode_ctc.yaml --verbose 2 --resume exp/seed_five_percent_pytorch_train_seed_model_five_percent_ctc_b32/results/snapshot.ep.100 --train_set seed_five_percent --recog_model model.loss.best --train_data bin2_on_phone.json

CUDA_VISIBLE_DEVICES=0 ./run_seed_bin.sh --ngpu 1 --timit /home/sumit/TIMIT --trans_type phn --stage 3 --tag "train_seed_model_five_percent_ctc_b32_with_B1_2_3_phone" --train_config ./conf/train_batch-size32_epochs200.yaml --decode_config ./conf/decode_ctc.yaml --verbose 2 --resume exp/seed_five_percent_pytorch_train_seed_model_five_percent_ctc_b32/results/snapshot.ep.100 --train_set seed_five_percent --recog_model model.loss.best --train_data bin3_on_phone.json

CUDA_VISIBLE_DEVICES=0 ./run_seed_bin.sh --ngpu 1 --timit /home/sumit/TIMIT --trans_type phn --stage 3 --tag "train_seed_model_five_percent_ctc_b32_with_B1_2_3_4_phone" --train_config ./conf/train_batch-size32_epochs200.yaml --decode_config ./conf/decode_ctc.yaml --verbose 2 --resume exp/seed_five_percent_pytorch_train_seed_model_five_percent_ctc_b32/results/snapshot.ep.100 --train_set seed_five_percent --recog_model model.loss.best --train_data bin4_on_phone.json

CUDA_VISIBLE_DEVICES=0 ./run_seed_bin.sh --ngpu 1 --timit /home/sumit/TIMIT --trans_type phn --stage 3 --tag "train_seed_model_five_percent_ctc_b32_with_B1_2_3_4_5_phone" --train_config ./conf/train_batch-size32_epochs200.yaml --decode_config ./conf/decode_ctc.yaml --verbose 2 --resume exp/seed_five_percent_pytorch_train_seed_model_five_percent_ctc_b32/results/snapshot.ep.100 --train_set seed_five_percent --recog_model model.loss.best --train_data bin5_on_phone.json
