#!/usr/bin/env bash

# Input files
RAW="../raw_data/raw_reads/INSERT_FILENAME_HERE"
FILTERED="../raw_data/filtered_reads/INSERT_FILENAME_HERE"

# Output directory
OUTDIR="../results/quality_check/compare_raw_filtered"

mkdir -p "${OUTDIR}"

NanoComp \
    --fastq "${RAW}" "${FILTERED}" \
    --names Raw Filtered \
    --threads 8 \
    --outdir "${OUTDIR}"

echo "NanoComp completed successfully."
echo "Results saved to: ${OUTDIR}"
