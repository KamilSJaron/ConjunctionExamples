#!/bin/bash

conjunction setting_D32_LM.txt 1> setting_D32_LM.out 2> setting_D32_LM.err
conjunction setting_onelocus_D32_LM.txt 1> setting_onelocus_D32_LM.out 2> setting_onelocus_D32_LM.err

Rscript ../scripts/compute_widths.R setting_D32_LM
Rscript ../scripts/compute_widths.R setting_onelocus_D32_LM

Rscript effect_of_dispersal.R
