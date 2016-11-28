library(ConjunctionStats)

GradTable <- ReadSetting('setting.txt')
GradTable <- GradTable[,c(1,7,8)]
GradTable$HI <- read.table('allele_freq_var_hi_only.out', header = F)$V1

deme_sizes <- unique(GradTable$D)
generations <- unique(GradTable$G)

allele_freq_var <- merge(data.frame(G = unique(GradTable$G)),
                         data.frame(D = unique(GradTable$D)))
allele_freq_var$allele_freq_var <- NA

for(deme_size in deme_sizes){
  for(generation in generations){
    one_generation_HI <- GradTable$HI[GradTable$G == generation &
                                      GradTable$D == deme_size]
    allele_freq_var$allele_freq_var[allele_freq_var$G == generation &
                                    allele_freq_var$D == deme_size] <- var(one_generation_HI)
  }
}

prediction <- function(G, deme_size){
  return(G * (0.25 / (2 * deme_size)))
}

pdf('variance_of_allele_frequency_under_drift.pdf')
  pal <- brewer.pal(3, "Set1")
  PlotStat(allele_freq_var, 'allele_freq_var', 'G', 'D', 'topleft',
           ylab = 'variance of allele frequency', xlab = "Generation", pal = pal)
  for(D in deme_sizes){
    col <- pal[which(D == deme_sizes)]
    lines(prediction(generations, D) ~ generations, col = col)
  }
dev.off()
