#!/bin/bash

conjunction 1> allele_freq_var.out 2> allele_freq_var.err

grep "0:" allele_freq_var.out | awk '{print $8}' > allele_freq_var_hi_only.out

Rscript gene_freq_under_drift.R
