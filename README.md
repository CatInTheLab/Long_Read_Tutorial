# Long-Read Sequencing Quality Control and Read Filtering Tutorial

## Overview

This tutorial introduces the first steps of analysing Oxford Nanopore long-read sequencing data. Before performing downstream analyses such as genome assembly, transcriptome analysis, taxonomic classification or variant detection, it is important to assess the quality of the sequencing reads and remove low-quality data.

This workflow is suitable for both **DNA** and **RNA** Oxford Nanopore sequencing datasets.

By completing this tutorial, you will learn how to:

* Navigate a Linux terminal.
* Create a Conda environment containing all required software.
* Download or organise the example sequencing data.
* Assess the quality of raw Nanopore reads using **NanoPlot**.
* Filter low-quality and short reads using **Chopper**.
* Compare the raw and filtered datasets using **NanoComp**.

---

# Workflow

```text
Raw FASTQ (Example dataset, or your basecalled sequencing output from MinKNOW)
    │
    ▼
NanoPlot (QC of long reads)
    │
    ▼
Chopper (Filter low quality / short reads)
    │
    ▼
NanoComp (Compare the QC of raw and filtered reads)
```

---

# Before You Begin

This tutorial is designed to be run from a Linux. Open the Ubuntu app.

## Display your current directory

```bash
pwd
```

Example output:

```text
/home/username
```

---

## List the files in your current directory

```bash
ls
```

---

## Change directories

Move into a directory:

```bash
cd madagascar_soil_project
```

Move into the scripts directory:

```bash
cd code
```

Move back one directory:

```bash
cd ..
```

---

## Check that you are in the correct location

Before running any scripts, check your current directory:

```bash
pwd
```

The output should be in a suitable location, like a folder for the Madagascar project.

```text
madagascar_soil_project
```

---

# Repository Structure

```text
nanopore_analysis/
├── README.md
├── environment.yml
├── code/
│   ├── 01_nanoplot_raw.sh
│   ├── 02_chopper.sh
│   └── 03_nanocomp.sh
├── raw_data/
│   ├── raw_reads/
│   └── filtered_reads/
├── results/
│   ├── quality_check_raw/
│   ├── quality_check_filtered/
│   └── nanocomp/
└── figures/
```

---

# Software Used

This tutorial uses the following software:

* NanoPlot
* NanoComp
* Chopper
* Python 3.11
* Conda

All required software is installed automatically using the supplied `environment.yml` file.

---

# 1. Clone the Repository

Clone the repository from GitHub:

```bash
git clone https://github.com/YOUR_USERNAME/nanopore_analysis.git
```

Move into the repository:

```bash
cd nanopore_analysis
```

---

# 2. Create the Conda Environment

Create the Conda environment:

```bash
conda env create -f environment.yml
```

Activate the environment:

```bash
conda activate nanopore_analysis
```

Verify that the software has been installed correctly:

```bash
NanoPlot --version
NanoComp --version
chopper --version
```

---


# 4. Example Dataset

The example dataset used in this tutorial is:

**Rapid library preparation from 16S gene amplified from soil metagenomic DNA isolated from different stages**

The run is stored on NCBI,here: https://www.ncbi.nlm.nih.gov/sra/SRX25347677?utm_source=chatgpt.com.
The SRA ID is SRR29850036. 

The FASTQ file is in the raw_data folder, inside the raw_reads file:

```bash
ls ../raw_data/raw_reads/
```

Your project directory should look like this:

```text
raw_data/
├── raw_reads/
│   └── SRR29850036.fastq
└── filtered_reads/
```

---

# 5. Quality Control of the Raw Reads

Run the NanoPlot script:

```bash
./scripts/01_nanoplot_raw.sh
```

NanoPlot provides a comprehensive overview of sequencing quality, including:

* Number of reads
* Total sequencing yield
* Read length distribution
* Mean read quality
* N50
* Read length versus quality
* Quality score distribution

Results are written to:

```text
results/quality_check_raw/
```

Open the HTML report in your web browser to explore the interactive plots.

---

# 6. Filter the Reads

Run:

```bash
./scripts/02_chopper.sh
```

This tutorial filters reads using:

* Minimum quality score: **Q10**
* Minimum read length: **1000 bp**

The filtered reads are written to:

```text
raw_data/filtered_reads/
```

These parameters provide a good balance between removing poor-quality reads while retaining informative long reads suitable for downstream analyses.

---

# 7. Compare Raw and Filtered Reads

Run:

```bash16
./scripts/04_nanocomp.sh
```

NanoComp compares the raw and filtered datasets, allowing you to evaluate how filtering affected:

* Number of reads
* Read quality
* Read length
* Read length distribution
* N50
* Total sequencing yield

Results are written to:

```text
results/nanocomp/
```

---

# Expected Outputs

After completing the tutorial your directory should resemble:

```text
results/
├── quality_check_raw/
└── nanocomp/
```

---

# Interpreting the Results

After filtering, you should observe:

* An increase in average read quality.
* Removal of very short reads.
* A cleaner read length distribution.
* A small reduction in total sequencing yield.
* An increase in the N50 if predominantly short reads were removed.

The exact changes will depend on the sequencing dataset and filtering parameters.

---

# Troubleshooting

## NanoPlot not found

Ensure the Conda environment is active:

```bash
conda activate nanopore_analysis
```

Verify the installation:

```bash
NanoPlot --version
```

---

## Chopper not found

Check the installation:

```bash
chopper --version
```

---

## NanoComp not found

Check the installation:

```bash
NanoComp --version
```

---

## FASTQ file not found

Confirm that the input FASTQ file is located in:

```text
raw_data/raw_reads/
```

---

## Output directory already exists

The scripts use:

```bash
mkdir -p
```

This safely creates output directories if they do not already exist, allowing the scripts to be run multiple times.

---

# Next Steps

Once the reads have passed quality control, they are ready for downstream analyses.

Possible next steps include:

### RNA

* Transcriptome alignment
* Transcript quantification

### 16S DNA Microbial Communities

* Taxonomic classification

The appropriate workflow depends on your sequencing experiment and biological question.

---


