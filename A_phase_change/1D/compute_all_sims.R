library(ConjunctionStats)

onelocus <- read.table('../A07_1D_sss_chromosome_number/setting_L1.tsv')
onelocus <- GetReplicateAverages(onelocus, filter = 1)

GradTable <- data.frame()

sim_names <- c(dir(pattern = '*tsv', path = 'weak_selection', full.names=T),
dir(pattern = '*tsv', path = 'weak_beta', full.names=T),
dir(pattern = '*tsv', path = 'init_search', full.names=T))

for(sim in sim_names){
  multilocus <- read.table(sim)
  multilocus <- FillClosestS(multilocus, onelocus)
  multilocus$file <- sim
  GradTable <- rbind(GradTable, multilocus)
}

GradTable <- FillSss(GradTable)
write.table(GradTable, 'GradTable_full.tsv')
