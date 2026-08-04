#!/usr/bin/env bash

set -euo pipefail

# RNA-Bloom transcriptome assembly
TRANSCRIPTOME="../results/assembly/rnabloom_insect_rna/rnabloom.transcripts.fa"

# Parent directory for BUSCO results
OUTPATH="../results/assembly_qc/busco_rnabloom_tarantula"

# Name of this BUSCO run
RUN_NAME="tarantula_transcriptome_busco"

# BUSCO lineage
LINEAGE="arthropoda_odb12"

# Number of CPU threads
THREADS=8

mkdir -p "${OUTPATH}"

echo "Starting BUSCO transcriptome completeness assessment..."
echo "Transcriptome: ${TRANSCRIPTOME}"
echo "Output: ${OUTPATH}/${RUN_NAME}"
echo "Lineage: ${LINEAGE}"
echo "Threads: ${THREADS}"

busco \
    -i "${TRANSCRIPTOME}" \
    -m transcriptome \
    -l "${LINEAGE}" \
    -o "${RUN_NAME}" \
    --out_path "${OUTPATH}" \
    -c "${THREADS}"

echo
echo "BUSCO completed."
echo "Results saved to: ${OUTPATH}/${RUN_NAME}"
echo "Summary files:"
find "${OUTPATH}/${RUN_NAME}" \
    -maxdepth 2 \
    -name "short_summary*.txt" \
    -print
