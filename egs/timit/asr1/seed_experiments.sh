./run_seed.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 3 --tag "train_seed_model" --train_config ./conf/train.yaml --verbose 2

./run_seed_prime.sh --ngpu 1 --timit /home/sumitc/TIMIT --trans_type phn --stage 3 --tag "train_seed_prime_model" --train_config ./conf/train.yaml --verbose 2 --oldtag "train_seed_model"
