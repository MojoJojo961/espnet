# train_nodev has 188 mins or roughly 3 hour data

#utils/subset_data_dir.sh --speakers data/train_nodev/ 800 data/train_nodev_subset 

# Taking the first n utterances for half hour seed model
utils/subset_data_dir.sh --first data/train_nodev/ 570 data/train_nodev_subset_train_half_hour 
utils/subset_data_dir.sh --first data/train_nodev/ 3126 data/train_nodev_subset_train_bulk_half_hour 

#Taking the first n utterances for one hour seed model
utils/subset_data_dir.sh --first data/train_nodev/ 1154 data/train_nodev_subset_train 
utils/subset_data_dir.sh --last data/train_nodev/ 2542 data/train_nodev_subset_bulk_one_hour
