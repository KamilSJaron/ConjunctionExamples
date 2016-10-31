library(ConjunctionStats)

GradTable <- read.table('width_estimates.tsv')

source('../75_effects_of_drift/filling_functions.R')
onelocus_HM_D32 <- read.table('../75_effects_of_drift/one_locus_D32_LM.tsv')
onelocus_HM_D32 <- getReplicateAverages(onelocus_HM_D32

GradTable$a_width <- NA
for(line in 1:nrow(GradTable)){
  GradTable$a_width[line] <- onelocus_HM_D32$width_H[GradTable$s[line] == onelocus_HM_D32$s]
}

source('../scripts/add_alpha.R')
nbetas <- length(unique(GradTable$b))
pal <- add.alpha(brewer.pal(nbetas,'Spectral')[1], 0.65)
for(i in 2:nbetas){
    pal <- c(pal, add.alpha(brewer.pal(nbetas,'Spectral')[i], 0.65))
}

GradTable$s <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)
GradTable$w_ratio <- GradTable$a_width / GradTable$width_H

pdf('width_ratio_vs_selection_beta.pdf')
PlotStat(GradTable, stat = 'w_ratio', par1 = 's', par2 = 'b',
         legend_position = 'topleft', pal = pal, add = F,
         xlab = 's + N(0,0.007)', ylab = 'single locus width / measured width')
dev.off()
