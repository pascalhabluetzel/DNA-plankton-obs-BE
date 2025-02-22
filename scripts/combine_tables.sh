#!/bin/bash

OUT="$VSC_DATA_VO_USER/EMOBON/MAGs_2025/results/20250219/test/"  # Set your output directory
COMBINED_FILE="$OUT/combined_coverm.tsv"

FILES=($OUT/*_coverm.tsv)
paste <(head -n 1 "${FILES[0]}") <(for file in "${FILES[@]:1}"; do head -n 1 "$file" | cut -f2-; done) > "$COMBINED_FILE"
paste <(tail -n +2 "${FILES[0]}") <(for file in "${FILES[@]:1}"; do tail -n +2 "$file" | cut -f2-; done) >> "$COMBINED_FILE"
