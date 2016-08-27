# Introgression of blocks in spatial clines

### Introduction

Baird and Barton have shown two phases of parametric space with the critical value of coupling
defining the edges. For the cases of low recombination and high selection, blocks
acting together but in the opposite case selection start to act independently on
every single loci. Baird and Barton's solution is not reflecting observations from nature,
where association of alleles is rather important aspect of introgression, but the
parametric space has recombination that strong that coupling coefficient will be
always on the wrong side of the phase regardless of the selection. However, the major
flaw of the approach is probably ignorance of the space, resulting in impossibility
of hybrid-hybrid mating.

### Explored parametric space

Here we are expanding original model with the stepping stone model in between of
two infinite population. We use approximation for infinite number of loci
per chromosome (10000) and many chromosomes (10 or 20). Parameter lambda is set
to 1.53 reflecting common recombination rates observed in many clades (ref).

Effects supposedly involved in the phase change:

- epistasis: epistasis is a mechanism that could help selection to be more effective
- selection: the model of selection used in the simulations is using fitness as
a relative measure of reproductibility within the deme - therefore the real effect of the
selection is different in the center and the edge of the cline.
- stochasticity: it is scaled with the size of demes, however the same parameter
(deme size) is also affecting an M: the number of native individuals entering the
cline.
- dispersal: The effect of M was evaluated using simulations with the same deme size,
but different dispersals (LM and HM)


### Methods

1. step was about finding a parametric space with the phase case.
To do that we simulate all combination of parameters for 100 generations.
Every cline the shape was evaluated using HZAR for average hybrid indexes in
space
2. once phase change was identified, we rerun simulations for 10000 generations
