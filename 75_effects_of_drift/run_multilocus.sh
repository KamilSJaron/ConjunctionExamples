#!/bin/bash

Rscript ../scripts/compute_widths.R setting_D32_LM
Rscript ../scripts/compute_widths.R setting_D32_HM
Rscript ../scripts/compute_widths.R setting_D64_HM
Rscript ../scripts/compute_widths.R setting_D128_HM
Rscript ../scripts/compute_widths.R setting_D256_HM
