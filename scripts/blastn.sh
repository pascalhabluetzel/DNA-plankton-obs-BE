#!/bin/bash

QUERY_FILE="$VSC_DATA_VO_USER/EMOBON/MAGs_2025/results/20250219/330/all/final.contigs.fa"
DB_NAME="$VSC_DATA_VO_USER/EMOBON/MAGs_2025/data/PR2/pr2_version_5.0.0_SSU_taxo_long.fasta"
OUTPUT_FILE="$VSC_DATA_VO_USER/EMOBON/MAGs_2025/results/20250219/blast_results_all.csv"
EVALUE="1e-5"
MAX_HITS=1  # Only report the top hit
THREADS=32

blastn -query "$QUERY_FILE" -db "$DB_NAME" -outfmt "6 qseqid sseqid length pident" -max_target_seqs "$MAX_HITS" -num_threads "$THREADS" -evalue "$EVALUE" > blast_results.tmp

echo "Query,Best_Hit,Alignment_Length,Percentage_Identity" > "$OUTPUT_FILE"
awk 'BEGIN {FS="\t"; OFS=","} {print $1, $2, $3, $4}' blast_results.tmp >> "$OUTPUT_FILE"
rm blast_results.tmp
