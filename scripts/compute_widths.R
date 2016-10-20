#!/usr/bin/env Rscript

# script reads output of simulations, compute widths and saves table with widths
# agruments: (# example)
# 1. name of setting file   # setting.txt
# 2. name of summary file   # my_sim.out
# 3. name of output table with widths   # talbe_with_widths.tsv

library(ConjunctionStats)

args <- commandArgs(trailingOnly=TRUE)

GradTable <- ReadSetting(args[1])
sim <- ReadSummary(args[2])
GradTable <- FillSettingByHZAR(sim, GradTable)

write.table(GradTable, args[3])
