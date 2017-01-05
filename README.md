# Conjunction Examples

is set of [Conjunction](https://github.com/KamilSJaron/Conjunction) simulations. These simulations supposed to serve for validation of the simulator (theoretical predictions are included) and for presentation and record of novel results.

Every set of simulations is in one folder, which contain:
 - `README.md` - the theoretical beckground
 - `Makefile` - a make script for running the analysis (see make help in any analysis folder or http://swcarpentry.github.io/make-novice/ for basic make tutorial)
 - `setting*.txt` - setting(s) used for the set of simulations
 - `*.R` - R scripts using R package [ConjunctionStats](https://github.com/KamilSJaron/ConjunctionStats) to generate
 - `figures` - subfolder with figures are expected to be created by the `Makefile`

## Requirements

- installed [Conjunction](https://github.com/KamilSJaron/Conjunction) (see instructions in the Conjunction's README file)
- installed R and R package [ConjunctionStats](https://github.com/KamilSJaron/ConjunctionStats) and its dependencies (HZAR, RColorBrewer)
- GNU make

# Sections

Simulations are categorised according the role in the publication (http://biorxiv.org/)

 - [V](V_verification): validation of Conjunction using analytical predictions of known settings
 - [A](A_phase_change): evaluation of phase change for three spatial models
 - [B](B_relative_selection): evaluation of the consequences of relative selection model
 - [N](N_non-published) simulations not discussed in publication


## Analyses for the manuscript

 - [A01](A01_0D_sss) 0D
 - [A04](A04_1D_sss) 1D
 - [A05](A05_1D_sss_under_drift) 1D drift
 - [A06](A06_1D_sss_dispersal_effect) 1D dispersal
 - [A07](A07_sss_related_to_chromosome_number) 1D chromosomes
 - [A08](A08_1D_sss_AUFC) 1D AUFC
 - [A09](A09_1D_lambda) 1D recombination rates (lambda)
 - [A10](A10_2D_sss) 2D



## licence

all examples and all images in this repository will be released into public domain once the results will be published.
