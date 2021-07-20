#!/bin/bash
#SBATCH --job-name=aupbH
#SBATCH --account=boucher
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marco.oliva@ufl.edu
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1024gb
#SBATCH --time=240:00:00
#SBATCH --output=%j_aupbH.log
#SBATCH --constraint='hpg3&amd&rome&infiniband'
#
# Asking for hpg-default 	128 	8 	16 	1 	1028 	hpg3;amd;rome;infiniband 	AMD EPYC 7702 64-Core Processor

##----------------------------------------------------------
# Print Some statistics
pwd; hostname; date;

if command -v lshw &> /dev/null
then
  lshw
else
  echo "lshw could not be found"
fi

##----------------------------------------------------------
# Setup
BASE_DIR_EXP="/blue/boucher/marco.oliva/projects/experiments/pfp"
BASE_DIR_PD="${BASE_DIR_EXP}/human_tests"
PROFILER="/usr/bin/time --verbose"
AUPAIR="/blue/boucher/marco.oliva/projects/experiments/pfp/repo/AuPair/aupair"

module load python/3.6
module load htslib
module load bcftools
module load git
module load gcc/9.3.0

d10_path="${BASE_DIR_PD}/02-06-2021_14-50-25"
d100_path="${BASE_DIR_PD}/02-06-2021_21-58-23"

##----------------------------------------------------------
# Run

${PROFILER} python ${AUPAIR} -w 10 -t 300 -b 10000 ${d10_path}/pfp
${PROFILER} python ${AUPAIR} -w 10 -t 300 -b 10000 ${d100_path}/pfp




