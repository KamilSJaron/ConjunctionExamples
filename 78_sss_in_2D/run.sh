#!/bin/bash

#conjunction onelocus_setting_2D.txt 1> onelocus_setting_2D.out 2> onelocus_setting_2D.err

Rscript ../scripts/compute_widths.R onelocus_setting_2D
Rscript ../scripts/compute_widths.R multilocus_setting_2D
