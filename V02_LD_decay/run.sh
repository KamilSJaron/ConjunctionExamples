#!/bin/bash

conjunction setting_L.txt > LD_loci.out 2> LD_loci.err
conjunction setting_C.txt > LD_chrom.out 2> LD_chrom.err
Rscript LD_decay.R
