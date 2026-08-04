#!/usr/bin/env bash

set -euo pipefail

# RNA-Bloom transcriptome assembly
TRANSCRIPTOME="../results/assembly/rnabloom_insect_rna/rnabloom.transcripts.fa"

# rnaQUAST output directory
OUTDIR="../results/assembly_qc/rnaquast_rnabloom_insect_rna"

# Number of CPU threads
THREADS=8

mkdir -p "${OUTDIR}"

echo "Starting rnaQUAST..."
echo "Transcriptome: ${TRANSCRIPTOME}"
echo "Output: ${OUTDIR}"
echo "Threads: ${THREADS}"

rnaQUAST.py \
    -c "${TRANSCRIPTOME}" \
    -o "${OUTDIR}" \
    -t "${THREADS}"

echo "rnaQUAST completed."
echo "Results saved to: ${OUTDIR}"
