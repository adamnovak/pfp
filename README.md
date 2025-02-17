# Prefix-Free Parsing #
[![CMake](https://github.com/marco-oliva/pfp/actions/workflows/cmake.yml/badge.svg?branch=master)](https://github.com/marco-oliva/pfp/actions/workflows/cmake.yml)
[![Conda](https://anaconda.org/bioconda/pfp/badges/version.svg)](https://anaconda.org/bioconda/pfp)

### Citing ###
This is an implementation of prefix-free parsing that was originally proposed by:

```
@article{boucher2019prefix,
  title={Prefix-free parsing for building big BWTs},
  author={Boucher, Christina and Gagie, Travis and Kuhnle, Alan and Langmead, Ben and Manzini, Giovanni and Mun, Taher},
  journal={Algorithms for Molecular Biology},
  volume={14},
  number={1},
  pages={1--15},
  year={2019},
  publisher={BioMed Central}
}
```

This has been modified to allow for optimization and allows for Variant Call Format (VCF) files to be used in replace of fasta files.  The publication corresponding to this work is as follows:

```
@inproceedings{oliva2022csts,
  title={CSTs for Terabyte-Sized Data},
  author={Oliva, Marco and Cenzato, Davide and Rossi, Massimiliano and Lipt{\'a}k, Zsuzsanna and Gagie, Travis and Boucher, Christina},
  booktitle={2022 Data Compression Conference (DCC)},
  pages={93--102},
  year={2022},
  organization={IEEE}
}
```

This work was supported by NIH R01AI141810 and made publicly available under GNU license.  If you use any parts of the repository, please acknowledge via citation of the above publications and this repository. 

### Install and Use ###

This tool produces the same result as running `bigbwt` on the fasta file generated as follow:

```
cat reference.fa | bcftools consensus calls.vcf.gz -H 1 > consensus.fa
```
Symbolic alleles are currently not supported, e.g. `<CN1>`. 

### Bioconda ###
PFP is available on `bioconda`:

```bash
conda install -c bioconda -c conda-forge pfp
pfp++ --help
```

### Docker ###
PFP is available on docker:

```bash
docker pull moliva3/pfp:latest
docker run moliva3/pfp:latest pfp++ --help
```

If using singularity:
```bash
singularity pull pfp_sif docker://moliva3/pfp:latest
./pfp_sif pfp++ --help
```

### Build ###

#### Dependencies ####

* Htslib
* OpenMP

#### Build Instructions ####

```
git clone https://github.com/marco-oliva/pfp.git
cd pfp
mkdir build && cd build
cmake ..
make
```

### Usage ###

```
PFP++
Usage: pfp++ [OPTIONS]

Options:
  -h,--help                   Print this help message and exit.
  -v,--vcf TEXT ...           List of comma ',' separated vcf files. Assuming in genome order!
  -r,--ref TEXT ...           List of comma ',' separated reference files. Assuming in genome order!
  -f,--fasta TEXT:FILE        Fasta file to parse.
  -i,--int32t TEXT:FILE       Integers file to parse.
  --int-shift UINT:INT in [0 - 200]
                              Each integer i in int32t input is interpreted as (i + int-shift).
  -H,--haplotype TEXT         Haplotype: [1,2,12].
  -t,--text TEXT:FILE         Text file to parse.
  -o,--out-prefix TEXT        Output prefix.
  -m,--max UINT               Max number of samples to analyze.
  -S,--samples TEXT           File containing the list of samples to parse.
  -w,--window-size UINT:INT in [3 - 200]
                              Sliding window size.
  -p,--modulo UINT:INT in [5 - 20000]
                              Modulo used during parsing.
  -j,--threads UINT           Number of threads.
  --tmp-dir TEXT:DIR          Temporary files directory.
  -c,--compress-dictionary    Also output compressed the dictionary.
  --use-vcf-acceleration      Use reference parse to avoid re-parsing.
  --print-statistics          Print out csv containing stats.
  --output-occurrences        Output count for each dictionary phrase.
  --output-sai                Output sai array.
  --output-last               Output last array.
  --acgt-only                 Convert all non ACGT characters from a VCF or FASTA file to N.
  --verbose                   Verbose output.
  --version                   Version number.
  --configure                 Read an ini file.
```
