#./run_seed.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 3 --tag "train_seed_model" --train_config ./conf/train.yaml --verbose 2

#./run_seed_prime.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 3 --tag "train_seed_prime_model" --train_config ./conf/train.yaml --verbose 2 --oldtag "train_seed_model"

#CUDA_VISIBLE_DEVICES=1 ./run_seed.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 3 --tag "train_seed_model" --train_config ./conf/train.yaml --verbose 2

#CUDA_VISIBLE_DEVICES=1 ./run_seed_prime.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 3 --tag "train_seed_prime_model_only_ctc" --train_config ./conf/train.yaml --verbose 2 --oldtag "train_seed_model_only_ctc"

#CUDA_VISIBLE_DEVICES=0 ./run_seed.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage -1 --tag "train_seed_model_five_percent" --train_config ./conf/train_dot_3l.yaml --verbose 2 --train_set seed_five_percent

#CUDA_VISIBLE_DEVICES=0 ./run_seed.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage -1 --tag "train_seed_model_twenty_five_percent" --train_config ./conf/train_dot_3l.yaml --verbose 2 --train_set seed_twenty_five_percent

CUDA_VISIBLE_DEVICES=0 ./run_seed.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 5 --tag "train_seed_model_five_percent" --train_config ./conf/train_dot_3l.yaml --decode_config ./confg/decode.yaml --verbose 2 --train_set seed_five_percent --recog_model model.acc.best

CUDA_VISIBLE_DEVICES=0 ./run_seed.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 5 --tag "train_seed_model_twenty_five_percent" --train_config ./conf/train_dot_3l.yaml --decode_config ./conf/decode.yaml --verbose 2 --train_set seed_twenty_five_percent --recog_model model.acc.best

CUDA_VISIBLE_DEVICES=0 ./run_seed.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 5 --tag "train_seed_model_five_percent_ctc" --train_config ./conf/train_dot_3l_ctc.yaml --decode_config ./confg/decode_ctc.yaml --verbose 2 --train_set seed_five_percent --recog_model model.loss.best

CUDA_VISIBLE_DEVICES=0 ./run_seed.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 5 --tag "train_seed_model_twenty_five_percent_ctc" --train_config ./conf/train_dot_3l_ctc.yaml --decode_config ./conf/decode_ctc.yaml --verbose 2 --train_set seed_twenty_five_percent --recog_model model.loss.best
