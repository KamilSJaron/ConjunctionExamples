### 1D

`sims/` - contain simulations of 1D clines with 200,000 loci per individual, deme size of 32 individuals, dispersal 0.5 and for 500 generations with save every 50 or 100. Selection (s), epistatis (beta), number of chromosomes (C) and recombination rate per chromosomes (lambda) were simulate in resonable ranges.
`A01_L6_convergence` - for L = 6, this sim is for comparison to exact results
`A02_L100_convergencemv` - for L = 100, this sim is to explore if extrapolation of exact result is in agreement with simulation of relatively low number of loci
`A03_drift` - fixed C (20), lambda (1.53) a for few betas and range of selection, range of deme sizes were explored
`A04_dispersal` - fixed C (20), lambda (1.53) a for few betas and range of selection, two values of dispersal were explored (0.25, 0.5)
`A05_dynamics` - fixed setting without replicates, two runs for 5000 generations and one for 10000 of cline that is just collapsing.

TODO: some makefiles
TODO: comon folder for figures
TODO: fix graphics
