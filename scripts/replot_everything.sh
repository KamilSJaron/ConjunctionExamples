#!/bin/bash
# should be executed from the root of the repository

echo A01
cd A01_0D_sss
Rscript effective_proportion_of_genome.R
cd ..

echo A02
cd A02_0D_sss_AUFC
Rscript effective_proportion_of_genome_epistasis.R
cd ..

echo A04
cd A04_1D_sss
Rscript plot_examples.R
Rscript 2_1D_initial_search_for_edge.R
cd ..

echo A05
cd A05_1D_sss_under_drift
Rscript effect_of_drift_on_phasechange.R
cd ..

echo A06
cd A06_1D_sss_dispersal_effect
Rscript effect_of_dispersal.R
cd ..

echo A07
cd A07_1D_sss_chromosome_number
Rscript effect_of_chromosomes_on_phasechange.R
cd ..

echo A08
cd A08_1D_sss_AUFC
Rscript sss_vs_AUFC.R
Rscript plot_edge_fitness_functions.R
cd ..

echo A09
cd A09_1D_lambda A10_2D_sss
Rscript couplig_coeff_eval.R
cd ..

echo A10
cd A10_2D_sss
Rscript phase_change_2D.R
cd ..
