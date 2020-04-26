## GNUPLOT command file
set data style lines
set size 0.78, 1.0
set noxtics
set noytics
set title 'DET plot for exp/seed_twenty_five_n_unlabel_pytorch_train_ground_truth_model_for_twenty_five_percent_ctc_b32/decode_test_decode_ctc/hyp.trn'
set nokey
set ylabel "Correct Words Removed (in %)"
set xlabel "Incorrect Words Retained (in %)"
set grid
set ytics ("0.1" -3.08, "0.5" -2.57, "2" -2.05, "5" -1.64, "10" -1.28, "20" -0.84, "30" -0.52, "40" -0.25, "50" 0.0, "60" 0.25, "70" 0.52, "80" 0.84, "90" 1.28, "95" 1.64, "98" 2.05, "99.5" 2.57, "99.9" 3.08)
set xtics ("0.1" -3.08, "0.5" -2.57, "2" -2.05, "5" -1.64, "10" -1.28, "20" -0.84, "30" -0.52, "40" -0.25, "50" 0.0, "60" 0.25, "70" 0.52, "80" 0.84, "90" 1.28, "95" 1.64, "98" 2.05, "99.5" 2.57, "99.9" 3.08)
plot [-3.290527:3.290527] [-3.290527:3.290527] \
 "exp/seed_twenty_five_n_unlabel_pytorch_train_ground_truth_model_for_twenty_five_percent_ctc_b32/decode_test_decode_ctc/hyp.trn.det.dat.00" using 2:1 title "exp/seed_twenty_five_n_unlabel_pytorch_train_ground_truth_model_for_twenty_five_percent_ctc_b32/decode_test_decode_ctc/hyp.trn" with lines 1
set ytics
set xtics
set size 1.0, 1.0
set key
