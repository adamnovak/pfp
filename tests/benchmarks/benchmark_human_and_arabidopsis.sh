#!/bin/bash
#SBATCH --job-name=ex-h&a
#SBATCH --account=boucher
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=marco.oliva@ufl.edu
#SBATCH --exclusive
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=60gb
#SBATCH --time=240:00:00
#SBATCH --output=%j_ex-h&a.log

##----------------------------------------------------------
# Print Some statistics
pwd; hostname; date

##----------------------------------------------------------
# Setup
BASE_DIR_EXP="/blue/boucher/marco.oliva/projects/experiments/pfp"
PROFILER="/usr/bin/time --verbose"

BENCHMARK_HUMAN="/blue/boucher/marco.oliva/projects/experiments/pfp/repo/pfp/tests/benchmarks/benchmark_human.py"
SAMPLES_LIST_BASE_HUMAN="/blue/boucher/marco.oliva/projects/experiments/pfp/repo/pfp/tests/benchmarks/input_list"

BENCHMARK_ARABIDOPSIS="/blue/boucher/marco.oliva/projects/experiments/pfp/repo/pfp/tests/benchmarks/benchmark_arabidopsis.py"
SAMPLES_LIST_BASE_ARABIDOPSIS="/blue/boucher/marco.oliva/projects/experiments/pfp/repo/pfp/tests/benchmarks/arabidopsis_input_list"

module load python
module load htslib
module load bcftools
module load git

${PROFILER} ${BENCHMARK_HUMAN} -t 32 -s "${SAMPLES_LIST_BASE_HUMAN}_10.txt"
${PROFILER} ${BENCHMARK_HUMAN} -t 32 -s "${SAMPLES_LIST_BASE_HUMAN}_100.txt"
${PROFILER} ${BENCHMARK_HUMAN} -t 32 -s "${SAMPLES_LIST_BASE_HUMAN}_200.txt"

${PROFILER} ${BENCHMARK_ARABIDOPSIS} -t 32 -s "${SAMPLES_LIST_BASE_ARABIDOPSIS}_25.txt"
${PROFILER} ${BENCHMARK_ARABIDOPSIS} -t 32 -s "${SAMPLES_LIST_BASE_ARABIDOPSIS}_125.txt"
${PROFILER} ${BENCHMARK_ARABIDOPSIS} -t 32 -s "${SAMPLES_LIST_BASE_ARABIDOPSIS}_250.txt"
${PROFILER} ${BENCHMARK_ARABIDOPSIS} -t 32 -s "${SAMPLES_LIST_BASE_ARABIDOPSIS}_500.txt"
${PROFILER} ${BENCHMARK_ARABIDOPSIS} -t 32 -s "${SAMPLES_LIST_BASE_ARABIDOPSIS}_1000.txt"

