# Conjunction Examples

is set of [Conjunction](https://github.com/KamilSJaron/Conjunction) simulations with known expectations. These simulations supposed to serve both as examples and validation (theoretical predictions are included).

Every set of simulations is in one folder, which contain:
 - `README.md` - the theoretical beckground
 - `run.sh` - one line bash cript running the simulation and its analysis
 - `setting` - setting used for the set of simulations
 - `*.R` - R scripts using R package [ConjunctionStats](https://github.com/KamilSJaron/ConjunctionStats) to generate
 - `expected_output` - subfolder with results expected to be generated if the script `run.sh` is executed

## Requirements

- installed [Conjunction](https://github.com/KamilSJaron/Conjunction) (see instructions in the Conjunction's README file)
- installed R and R package [ConjunctionStats](https://github.com/KamilSJaron/ConjunctionStats) and its dependencies (HZAR, RColorBrewer, ?)

## List of simulations

2. decay of linkage disequllibria given recombination rate of two loci

## to do

1. ?? the rate of increase of gene frequency variance under drift 
3. collapsion of a 1D cline without selection given dispersal
4. ?? the decrease in correlation between gene frequency fluctuations under migration, heterozygote advantage, and drift have to be according the prediction of Malecot (1948)
5. the width of one locus 1D cline given selection and dispersal (Bazykin 1969)
6. the shape of a cline given an epistatic selection (original ref)
