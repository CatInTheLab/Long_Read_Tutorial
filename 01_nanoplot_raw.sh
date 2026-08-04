#!/usr/bin/env bash

set -euo pipefail

# Input FASTQ
READS="../raw_data/raw_reads/INSERT_FILENAME_HERE"

# NanoPlot output directory
OUTDIR="../results/quality_check/raw_reads/INSERT_FILENAME_HERE"

# Number of CPU threads
THREADS=8

mkdir -p "${OUTDIR}"

echo "Starting NanoPlot..."
echo "Input: ${READS}"
echo "Output: ${OUTDIR}"
echo "Threads: ${THREADS}"

NanoPlot \
    --fastq "${READS}" \
    --outdir "${OUTDIR}" \
    --threads "${THREADS}" \
    --loglength \
    --N50

echo "NanoPlot completed."
echo "Results saved to: ${OUTDIR}"
