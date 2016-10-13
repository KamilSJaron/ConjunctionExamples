
## Logic behind proportion of genome acting togheder

The selection defined in simulation is overall selection acting on all loci, therefore selection carried by every single loci is `s / (L * C)`, where `s` is overall selection, `L` is number of loci per chromosome and `C` is number of chromosomes. However, loci are phisically linked. The linkage is broken through segregation and recombination of moreless realistic (1.53 chiasmas per chromosome per meiosis)).

The simulation of one dimensional cline with this [(setting.txt)] produces a cline of a width, this is estimated using HZAR package. Using the estimate of the width, we can estimate a selection that would produce a cline of the same width. Using Bazykin's diffusion approximation definiing relation between width, dispersal (`sigma`) and selection `s  = (8 * sigma) / w^2`. 
Let's call the selection need to maintain the onelocus cline of the same width `s*`. The ratio `s* / s` the makes a proportion genome acting together.

[(./expected_results/propotion_of_genome_vs_selection)]

A use one measure for selection combination the strength of selection together with strength of epistatis (`beta`). The area under fitness curve (AUFC) was computed for every combination of `s` and `beta` and used to explain the very same measure of proportion of genome acting together.

[(./expected_results/propotion_of_genome_vs_AUFC.pdf)]

Well, we see rather steep phase transition between seletion 0.65 and 0.75. That is good, but how comes that a lot of points are over one, which means, that we observe multilocus clines of steeper width that it is theoretically possible to stable maintain. Well, what is going on? We know that drift actually makes the individual observations of cline steeper, but that steeper?

There are two alternative aproaches I figured out...


### difference between selection in the center and on the edge of the cline

The fitness of individuals is relative in the simulation therefore we can estimate where the barrier lays by ratio of absolute selection (1 - absolute fitness) acting on maximally admixed individuals at the edge of the cline and in the center.

[(./expected_results/propotion_of_selection_vs_selection.pdf)]

we see that this measure actually show the same phase transition as the previous one, however it is bounded by biologically interpretable limits.

### Measuring width with drift empirically

instead using diffusion approximation that is not taking drift into account, we could simulate one locus cline with the same under the same selections and drift as our multilocuscases, evaluated at [(../74_one_locus_widths)]


