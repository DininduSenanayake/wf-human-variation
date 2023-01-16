#!/bin/bash -e 

#SBATCH --account nesi99999
#SBATCH --job-name ont-variant-callling
#SBATCH --cpus-per-task 32
#SBATCH --mem 128G
#SBATCH --time 01:00:00
#SBATCH --output /nesi/nobackup/nesi99999/Dinindu/ZDissues/wf-human-variation/slurmout/%j.%x.out

module purge
module load Nextflow/22.10.3
module load Singularity/3.10.3

export SINGULARITY_TMPDIR='/nesi/nobackup/nesi99999/Dinindu/ZDissues/wf-human-variation/singularity_tmpcache'
export SINGULARITY_CACHEDIR=$SINGULARITY_TMPDIR

export NXF_EXECUTOR=slurm
export NXF_SINGULARITY_CACHEDIR=/nesi/nobackup/nesi99999/Dinindu/ZDissues/wf-human-variation/singularity_tmpcache

DEMO_DATA='/nesi/nobackup/nesi99999/Dinindu/ZDissues/wf-hv-demo_data'
MODEL='/nesi/nobackup/nesi99999/Dinindu/ZDissues/wf-hv-demo_data/ont_r104_e81_sup_g5015'
REFERENCE='nesi/nobackup/nesi99999/Dinindu/ZDissues/wf-hv-demo_data/demo.fasta'
TDREPETS='/nesi/nobackup/nesi99999/Dinindu/ZDissues/wf-hv-demo_data/human_GRCh38_no_alt_analysis_set.trf.bed'
OUTPUT='/nesi/nobackup/nesi99999/Dinindu/ZDissues/wf-hv-demo_data/results'
NFCONFIG='/nesi/nobackup/nesi99999/Dinindu/ZDissues/wf-human-variation/nextflow.config'


# pull nextflow pipeline (if haven't already)
nextflow run epi2me-labs/wf-human-variation --help  
  
nextflow -c ${NFCONFIG} run epi2me-labs/wf-human-variation \
    -profile singularity,local \
    --snp --sv \
    --bam $DEMO_DATA/demo.bam \
    --bed $DEMO_DATA/demo.bed \
    --ref $DEMO_DATA/demo.fasta \
    --model $DEMO_DATA/ont_r104_e81_sup_g5015 \
    --sample_name DEMO \
    --out_dir ${OUTPUT} \
    --threads $SLURM_CPUS_PER_TASK
    
    
