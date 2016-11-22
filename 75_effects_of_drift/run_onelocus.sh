#!/bin/bash

Rscript ../scripts/compute_widths.R setting_onelocus_D32_LM
Rscript ../scripts/compute_widths.R setting_onelocus_D32
Rscript ../scripts/compute_widths.R setting_onelocus_D64
Rscript ../scripts/compute_widths.R setting_onelocus_D128
Rscript ../scripts/compute_widths.R setting_onelocus_D256
