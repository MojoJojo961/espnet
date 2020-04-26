# 5% data 
#sh utils/subset_data_dir.sh --first data/train_nodev/ 185 data/seed_five/

# 25% data
#sh utils/subset_data_dir.sh --first data/train_nodev/ 899 data/seed_twenty_five/

# bulk two hour
#sh utils/subset_data_dir.sh --last data/train_nodev/ 2542 data/bulk_two_hour/

# seed + unlabel for 5%
#. utils/combine_data.sh data/seed_five_n_unlabel data/seed_five_percent/ data/bulk_two_hour/

# seed + unlabel for 25%
. utils/combine_data.sh data/seed_twenty_five_n_unlabel data/seed_twenty_five_percent/ data/bulk_two_hour/
