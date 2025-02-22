#!/bin/bash

DATA="$VSC_DATA_VO/shared/NCS_Group/rRNA_from_seasonal/rRNA"
OUT="$VSC_DATA_VO_USER/EMOBON/MAGs_2025/results/20250219/test/"

for R1 in $DATA/*_R1.rRNA.fastq.gz; do
    R2=${R1/_R1/_R2}    
    SAMPLE_NAME=$(basename "$R1" | sed 's/_R1.rRNA.fastq.gz//')
    coverm contig -t 32 --coupled "$R1" "$R2" \
        --reference $VSC_DATA_VO_USER/EMOBON/MAGs_2025/results/20250219/330/all/final.contigs.fa \
        --output-file "$OUT/${SAMPLE_NAME}_coverm.tsv"
done
