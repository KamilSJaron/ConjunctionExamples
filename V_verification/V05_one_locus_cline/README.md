# The width of one locus cline as function of selection and dispersal

"The width and shape of clines maintained by heterozygote disadvantage and epistasis was as expected when selection is weak"

The models the simulation is compared to are the diffusion approximation of the one locus cline using selection and dispersal (Bazykin 1969) and the model of multiple loci under epistatic selection (Barton and Gale 1993). 

The width of one locus cline maintained by heterozygote disadvantage is sqrt(8) * σ / sqrt(s*)

where σ is a square root of dispersal and s^* is a disadvantage of heterozygotes. The equation is giving us a prediction for the width of the simulated clines. The implementation of the simulator allowed simulating two rates of migration in the chain of demes (m = ½ and m = ¼ respectively). The selection was chosen in the gradient from 0.05 to 0.95 and deme size was chosen to minimize genetic drift (1024 individuals per deme). We have estimated a slope of the cline by fitting a logistic curve to average hybrid indexes for every simulation. The width of the cline is then 4 / slope. Estimated widths are compared to theoretical prediction in [Figure](expected_output/Bazykin.pdf), showing exact match for low selection and reasonable the difference for higher selection possibly explainable by discrete order of events of the simulation compared to diffusion approximation where selection, reproduction and migration are acting all in the same time.
