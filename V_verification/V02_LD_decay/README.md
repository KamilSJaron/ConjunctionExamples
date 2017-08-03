"Recombination: linkage disequilibrium has to decay at rate (1-r)^t"

This test demonstrates correct implementation of multiple chromosomes in one individual, because segregation effectively acts as recombination rate r = 0.5. In one deme we introduce half of individuals from population A and second by individuals of population B and we set the selection to zero. Therefore before the first generation the LD is maximal. All borders of the deme are reflexive, so there is no migration to produce additional LD. Hence, for two chromosomes per individual we expect decay at rate  (0.5)^t. The same expectation we have for one chromosome per individual, two loci per chromosome and lambda set to three (computed using Haldane mapping function ref my thesis). For one chromo some, two loci per chromosome and lambdas 0.25 and 0.5, we expect decay at rate (0.19)^t  and (0.31)^t  respectively (computed again using Haldane mapping function).