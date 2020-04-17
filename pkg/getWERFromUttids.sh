~/kaldi/tools/sctk/bin/sclite -r ../ref.trn -h ../hyp.trn -i rm -C det -o snt stdout > result2.txt

cat result2.txt | grep "id:" | cut -d ' ' -f2- | sed -e 's/[()]//g' | cut -d '-' -f2- | tr '[:lower:]' '[:upper:]' > uttids

cat result2.txt | grep "Errors" | cut -d '=' -f2- | tr -s " " | awk '{print $1}' | sed -e 's/\%//g' > WERs

paste -d ',' uttids WERs > uttid2wer.csv
