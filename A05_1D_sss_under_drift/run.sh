#!/bin/bash

# add here conjunction

Rscript ../scripts/compute_widths.R setting_D16_HM
Rscript ../scripts/compute_widths.R setting_D32_HM
Rscript ../scripts/compute_widths.R setting_D64_HM
Rscript ../scripts/compute_widths.R setting_D128_HM
Rscript ../scripts/compute_widths.R setting_D256_HM

Rscript ../scripts/compute_widths.R setting_onelocus_D16
Rscript ../scripts/compute_widths.R setting_onelocus_D32
Rscript ../scripts/compute_widths.R setting_onelocus_D64
Rscript ../scripts/compute_widths.R setting_onelocus_D128
Rscript ../scripts/compute_widths.R setting_onelocus_D256
