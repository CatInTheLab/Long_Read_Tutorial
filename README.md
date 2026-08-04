# Long-Read Sequencing Quality Control and Read Filtering Tutorial

## Overview
 Written by me and ChaptGPT:) 
 
This tutorial introduces the first steps of analysing Oxford Nanopore long-read sequencing data. Before performing downstream analyses such as genome assembly, transcriptome analysis, taxonomic classification or variant detection, it is important to assess the quality of the sequencing reads and remove low-quality data.

This workflow is suitable for both **DNA** and **RNA** Oxford Nanopore sequencing datasets.

By completing this tutorial, you will learn how to:

* Navigate a Linux terminal.
* Create a Conda environment containing all required software.
* Download or organise the example sequencing data.
* Assess the quality of raw Nanopore reads using **NanoPlot**.
* Filter low-quality and short reads using **Chopper**.
* Compare the raw and filtered datasets using **NanoComp**.

RNA Transcriptome Specific workflow:

---

# 16S DNA Workflow

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

# RNA Transcriptome Workflow

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
    │
    ▼
Rattle (Assembly of long read transcriptome)
    │
    ▼
Quast (QC of transcriptome assembly)
    │
    ▼
BUSCO (QC of transcriptome assembly)
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
## Creating and Running Your First Bash Script

Before running the analysis pipelines, it is useful to become familiar with creating and executing a simple Bash script.

### Create a new directory

Create a directory called `code` and move into it:

```bash
mkdir code
cd code
```

### Create a new script

Create a new file called `hello_world.sh` using the Nano text editor:

```bash
nano hello_world.sh
```

Copy and paste the following line into the editor:

```bash
#!/usr/bin/env bash

echo "Hello, world!"
```

### Save and exit Nano

1. Press **Ctrl + O** to save the file.
2. Press **Enter** to confirm the filename.
3. Press **Ctrl + X** to exit Nano.

### Make the script executable

By default, the script cannot be executed. Grant execute permissions using:

```bash
chmod +x hello_world.sh
```

### Run the script

Execute the script:

```bash
./hello_world.sh
```

The output should be:

```text
Hello, world!
```

The remaining scripts in this tutorial are run in exactly the same way.

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
│   │   ├── SRR32537182_insect_rna.fastq
│   │   ├── SRR29850036_bacteria_16s.fastq
│   └── filtered_reads/
├── results/
│   ├── quality_check/raw_reads/
│   ├── quality_check/compare_raw_filtered/
```

---

# Software Used

This tutorial uses the following software:

* NanoPlot
* NanoComp
* Chopper
* Rattle
* Quast
* BUSCO
* Python 3.11
* Conda

All required software is installed automatically using the supplied `environment.yml` file.

---

# 1. Clone the Repository

Clone the repository from GitHub:

```bash
git clone https://github.com/CatInTheLab/Long_Read_Tutorial.git
```

Move into the repository:

```bash
cd Long_Read_Tutorial
```

---

# 2. Create the Conda Environment - Windows people using Ubuntu 

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
rattle --help
rnaQUAST.py --help
busco --help
```
Navigate to the scripts directory
```bash
cd code
```

Add permission to all scripts
```bash
chmod +x *.sh
```
---
## Create a Conda Environment Manually in VS Code

If you have a mac - this is the workaround for now. Open VS code, then open a terminal. 

Create a new environment called `nanopore_analysis`:

```bash
conda create -n nanopore_analysis python=3.11
```

Activate the environment:

```bash
conda activate nanopore_analysis
```

Install NanoPlot, NanoComp, and Chopper:

```bash
conda install -c conda-forge -c bioconda \
    nanoplot \
    nanocomp \
    chopper
```

Check that the programs installed correctly:

```bash
NanoPlot --version
NanoComp --version
chopper --version
```

Once these commands return version information, the environment is ready to use.


# 3. Example Dataset

The example 16S DNA dataset used in this tutorial is:

**Rapid library preparation from 16S gene amplified from soil metagenomic DNA isolated from different stages**

The run is stored on NCBI,here: https://www.ncbi.nlm.nih.gov/sra/SRX25347677[accn]
The SRA ID is SRR29850036. 

The example RNA dataset used in this tutorial is:

**RNAseq of Philippine tarantulas**

The run is stored on NCBI,here: https://www.ncbi.nlm.nih.gov/sra/SRX27848373[accn].
The SRA ID is SRR32537182. 

Download your desired dataset and place in the raw_data folder, inside the raw_reads file:
https://unsw-my.sharepoint.com/:f:/g/personal/z5205630_ad_unsw_edu_au/IgC00uU0acw0T4_b4XSu2BbvAS6u-NsRmxOF_ksZRAGccSo?e=CJy1sy

```bash
ls ../raw_data/raw_reads/
```

Your project directory should look like this:

```text
raw_data/
├── raw_reads/
│   └── SRR29850036_bacteria_16s.fastq
│   └── SRR32537182_insect_rna.fastq
└── filtered_reads/
```

---
## Running the Analysis Scripts

All analyses in this tutorial are performed using Bash scripts located in the `code` directory. If you would like to inspect or modify a script before running it, you can open it using the Nano text editor.

For example, to open the first script:

```bash
nano 01_nanoplot_raw.sh
```

You can edit any part of the script, such as the input file, output directory, or analysis parameters. Once you have finished making changes:

1. Press **Ctrl + O** to save the file.
2. Press **Enter** to confirm the filename.
3. Press **Ctrl + X** to exit Nano.

Run a script using:

```bash
./01_nanoplot_raw.sh
```

The script will display its progress in the terminal and write the output files to the appropriate directory specified within the script.

---


# 4. Quality Control of the Raw Reads



Run the NanoPlot script:

```bash
./01_nanoplot_raw.sh
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
../results/quality_check/raw_reads/
```

Open the HTML report in your web browser to explore the interactive plots.

---

# 5. Filter the Reads

Run:

```bash
./02_chopper.sh
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

# 6. Compare Raw and Filtered Reads

Run:

```bash16
./03_nanocomp.sh
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
../results/quality_check/compare_raw_filtered/
```



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

* Transcriptome annotation

### 16S DNA Microbial Communities

* Taxonomic classification

The appropriate workflow depends on your sequencing experiment and biological question.

---


