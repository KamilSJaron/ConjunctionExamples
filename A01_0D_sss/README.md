### Introduction

Baird and Barton have shown two phases of parametric space with the critical value of coupling
defining the edges. For the cases of recombination lower than selection, big blocks of genome
are acting together, but if the selection is lower then recombination, every loci start to act independently. Baird and Barton's solution is not covering all of the observations from nature.
We can find numerous hybrid zones, where association of alleles is rather important aspect of introgression,
which according previous solution requires very low recombination rates,
so the coupling coefficient is greater than one.

### Presented models

We focus on multilocus clines, where selection acting on every single loci is
close to zero. We use approximation for infinite number of loci
per individual (200,000) spread over 20 chromosomes.
Parameter lambda is set to 1.53 representing biologically relevant recombination rates.

Original phase change was described by coupling coefficient theta defined as selection / recombination:

- recombination rate - fixed to 1.53 to reduce parametric space
- selection: is always simulated on computationally reasonable range to simulate all possible thetas

Effects we explore that possibly involved in the phase change:

 - epistasis: epistasis is a mechanism that could help selection to be more effective
 - stochasticity: the idea is that drift is breaking cascades of blocks at the beginning of the introgression so the effect of the cascade can result in fewer small blocks and therefore slower introgression.
 - number of chromosomes: will increase the effect of recombination rate
 - space: Here we present three spatial models; 0D - that is analogical to Baird 1995; 1D stepping stone model: chain of demes with fixed deme size is linking two infinite populations; 2D stepping stone model, where grid of simulated demes is formed into torus

### Take home from this sim

There is no critical value in this parametric subspace, more relaxed epistatic interactions have to be explored (A02).

Approximate convergence is rather fast, therefore at least initial space search can be performed on limited number of generation (50) with more replicates.

Analogical model with 1D spatial model is in folder A04.
