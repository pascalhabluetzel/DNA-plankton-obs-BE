#!/bin/bash

FILE1="$VSC_DATA_VO_USER/EMOBON/MAGs_2025/results/20250219/test/combined_coverm.tsv"
FILE2="$VSC_DATA_VO_USER/EMOBON/MAGs_2025/results/20250219/blast_results_all.csv"
COL1="Contig"
COL2="Query"
OUTPUT_FILE="$VSC_DATA_VO_USER/EMOBON/MAGs_2025/results/20250219/test/ASVxSite_table.tsv"

DELIM1=$'\t'  
DELIM2=','    

COL1_IDX=$(head -n 1 "$FILE1" | tr "$DELIM1" '\n' | nl -v0 | grep -w "$COL1" | awk '{print $1+1}')
COL2_IDX=$(head -n 1 "$FILE2" | tr "$DELIM2" '\n' | nl -v0 | grep -w "$COL2" | awk '{print $1+1}')

awk -v col1="$COL1_IDX" -v col2="$COL2_IDX" -v FS="$DELIM1" -v FS2="$DELIM2" -v OFS="$DELIM1" '
    BEGIN { 
    }
    NR==FNR {
        key=$col1;
        $col1=""; gsub(/^\t|\t$/, "", $0);
        data[key]=$0;
        next;
    }
    FNR==1 {
        print $0, "Merged_Data";
        next;
    }
    {
        key=$col2;
        if (key in data) {
            print $0, data[key];
        } else {
            print $0, "NA";
        }
    }
' "$FILE1" FS="$DELIM2" "$FILE2" > "$OUTPUT_FILE"
