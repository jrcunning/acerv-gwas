#!/bin/bash
#BSUB -J adig_ips
#BSUB -o %J.out
#BSUB -e %J.err
#BSUB -q general
#BSUB -P crf
#BSUB -W 48:00
#

module load java/1.8.0_60

export _JAVA_OPTIONS=''

cd /scratch/projects/crf/acerv-gwas/annotations
interproscan.sh -i adig_proteins.faa -b adig_ips --goterms

sed -n 's/\(aug_v2a.........\).*\(GO:.*\)/\1 \2/p' adig_ips.tsv | sort | uniq | awk -F' ' -v OFS=', ' '{x=$1;$1="";a[x]=a[x]$0}END{for(x in a)print x,a[x]}' | sed 's/, , /\t/g' > adig_ips_GO.txt
