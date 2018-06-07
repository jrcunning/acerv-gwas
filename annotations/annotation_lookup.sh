#!/bin/bash

IFS=$'\n'
for LINE in $(cat 0_GBM_class_loci.txt); do
    export SCAF=$(echo $LINE | awk '{print $1}')
    export POS=$(echo $LINE | awk '{print $2}')
    awk -v SCAF="$SCAF" -v POS="$POS" '($1==SCAF) && ($4<int(POS)) && ($5>int(POS)) {print $0}' Ref_Adig_1_scaffolds.txt >> 1_results.txt
done

grep 'exon' 1_results.txt > 2_exons.txt
egrep -o 'X[MR]_\d+\.1' 2_exons.txt > 3_exon_ascensions.txt
awk '!seen[$0]++' 3_exon_ascensions.txt >3b_unique_ascensions.txt

