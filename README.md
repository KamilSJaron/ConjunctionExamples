# Conjunction Examples

is set of [Conjunction](https://github.com/KamilSJaron/Conjunction) simulations with known expectations. These simulations supposed to serve both as examples and validation (theoretical predictions are included).

Every set of simulations is in one folder, which contain:
 - `README.md` - the theoretical beckground
 - `run.sh` - one line bash cript running the simulation and its analysis
 - `setting*.txt` - setting(s) used for the set of simulations
 - `*.R` - R scripts using R package [ConjunctionStats](https://github.com/KamilSJaron/ConjunctionStats) to generate
 - `expected_output` - subfolder with results expected to be generated if the script `run.sh` is executed

## Requirements

- installed [Conjunction](https://github.com/KamilSJaron/Conjunction) (see instructions in the Conjunction's README file)
- installed R and R package [ConjunctionStats](https://github.com/KamilSJaron/ConjunctionStats) and its dependencies (HZAR, RColorBrewer)

# Content

There are two series of simulations:

 - V01 - V0X validation of Conjunction using analytical predictions of known settings
 - A01 - AXX novel results for multilocus clines

### Simulation for validation

 - [V01](V01_gene_frequency_variance_under_drift) the rate of increase of gene frequency variance under drift
 - [V02](V02_LD_decay) Ddecay of linkage disequllibria given recombination rate of two loci
 - [V03](V03_collapse) collapse of a 1D cline without selection 
 - [V04](V04_frequency_fluctuations) the decrease in correlation between gene frequency fluctuations under migration, heterozygote advantage, and drift have to be according the prediction (Malecot 1948)
 - [V05](V05_one_locus_cline) the width of onelocus cline confronted to diffustion approximation (Bazykin 1969)
 - [V06](V06_epistasis) the shape of multilocus cline maintained by epistatic selection (Baron & Gale 1993)
 - [V07](V07_0D_multilocus_clines) proportion of genome acting together in spatial less simulation (Baird 1995)

## Abalyses for the manuscript


## Non-published simulations

 - [N01_departures_from_Hardy–Weinberg] observed and theorietiacl population departure from Hardy–Weinberg equillibrium
 - [N02_onelocus_clines_under_drift] the width of onelocus clines under dirft

## licence

all examples and all images in this repository will be released into public domain once the results will be published.

