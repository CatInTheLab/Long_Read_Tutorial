#!/usr/bin/env bash

set -euo pipefail

# Input FASTQ
READS="../raw_data/raw_reads/INSERT_FILENAME_HERE"

# Filtered reads output directory
OUTDIR="../raw_data/filtered_reads"

# Output FASTQ
OUTPUT="${OUTDIR}/INSERT_FILENAME_HERE"

# Filtering parameters - you can change then as you wish
MIN_QUALITY=10
MIN_LENGTH=1000

mkdir -p "${OUTDIR}"

echo "Starting Chopper..."
echo "Input: ${READS}"
echo "Output: ${OUTPUT}"
echo "Minimum quality: Q${MIN_QUALITY}"
echo "Minimum length: ${MIN_LENGTH} bp"

cat "${READS}" | \
chopper \
    -q "${MIN_QUALITY}" \
    -l "${MIN_LENGTH}" \
    > "${OUTPUT}"

echo "Chopper completed."
echo "Filtered reads saved to: ${OUTPUT}"
