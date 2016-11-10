#!/usr/bin/env Rscript

# script reads output of simulations, compute widths and saves table with widths
# agruments: (# example)
# 1. base of the setting and summary file, base.txt/base.out file, output will be saved to base.tsv
### OR ###
# 1. name of setting file   # setting.txt
# 2. name of summary file   # my_sim.out
# 3. name of output table with widths   # talbe_with_widths.tsv

library(ConjunctionStats)

args <- commandArgs(trailingOnly=TRUE)

if(length(args) == 1){
  setting_file = paste(args[1], 'txt', sep = '.')
  summary_file = paste(args[1], 'out', sep = '.')
  output_file = paste(args[1], 'tsv', sep = '.')
} else {
  stopifnot(length(args) == 3)
  setting_file = args[1]
  summary_file = args[2]
  output_file = args[3]
}

GradTable <- ReadSetting(setting_file)
sim <- ReadSummary(summary_file)
GradTable <- FillSetting(sim, GradTable)

write.table(GradTable, output_file)
