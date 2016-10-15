# One locus widths under fixed effect of drift

So, we know that we do not have reliable estimate of cline widths under drift,
or that the method we are using for estimation of width is not appropriate for
wide clines.

![Code used for analysis](one_locus_drift_widths.R)

## one locus simulation.

Well, we do not have the theory, so let's make some... Using ![setting](one_locus_setting.txt)
we simulate a width of one locus clines with fixed drift (deme size is 16).
The summary is saved every 100 generation and every simulation is replicated 5 times.

Widths are estimated using HZAR and plotted in ![Fig 1](widths_vs_selection_L1.pdf).
A line represent diffusion approximation.

Taking means of widths allows us to create a dictionary of widths and corresponding
selection of one locus clines under the fixed effect of drift.

## multi locus simulation

We re-simulate the dataset we had in ![](../73_searching_for_edge) with 5 replicates
per simulation (![setting](many_loci_setting.txt)), but slightly narrower grid of parameters.
There is a sharp edge (selection < 0.7 and beta < 0.25) of simulations
which have not converged within the first 100 generations and those that quickly converged.
For visualisation purposes, selection and beta was recalculated to integral of
![the fitness function](https://github.com/KamilSJaron/Conjunction/wiki/selection)
as `1 - (4^beta * selection * gamma(beta + 1)^2) / (gamma(2 * beta + 2))`, where
`gamma` is a Gamma function. Colour code shows a generation of a measurement, ![Fig 2](multilocus_widths_vs_AUFC_and_generation.pdf).

## Effective proportion of genome acting together

So we simulated widths of multilocus clines under several conditions,
now we can find selections needed to generate those widths in one locus clines
using dictionary created above.

The proportion of the corresponding one locus selection to
actual selection used for simulation then gives us a proportion of genome
acting together (See ![Fig 3](proportion_of_genome_vs_selection.pdf)). Few values
are slightly over one, which is probably just noise in width estimation
of steep clines (in fact combination of noise in estimation of single locus clines
and multilocus clines, which I tried to minimize by using 5 replicates and all
time points).

I should probably simulate also some values exactly on the edge
