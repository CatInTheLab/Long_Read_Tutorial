#!/usr/bin/env bash

set -euo pipefail

# Input direct RNA FASTQ
READS="../raw_data/filtered_reads/SRR32537182_insect_rna/SRR32537182_insect_rna.fastq"

# Output directory
OUTDIR="../results/assembly/rnabloom_insect_rna"

# Number of CPU threads
THREADS=8

mkdir -p "${OUTDIR}"

echo "Starting RNA-Bloom transcriptome assembly..."
echo "Input: ${READS}"
echo "Output: ${OUTDIR}"
echo "Threads: ${THREADS}"

rnabloom \
    -long "${READS}" \
    -stranded \
    -t "${THREADS}" \
    -outdir "${OUTDIR}"

echo "RNA-Bloom assembly completed."
echo "Main transcriptome: ${OUTDIR}/rnabloom.transcripts.fa"
