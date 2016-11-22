library(ConjunctionStats)
library(RColorBrewer)

# sigma^2 = 0.5, D=32, C=20
multilocus_C20 <- read.table('../75_effects_of_drift/multilocus_D32_HM.tsv')
onelocus_C20 <- read.table('../75_effects_of_drift/one_locus_D32_HM.tsv')
onelocus_C20 <- GetReplicateAverages(onelocus_C20, filter = 1)
multilocus_C20 <- FillClosestS(multilocus_C20, onelocus_C20)
multilocus_C20$LogL <- NA

#### CHECK IF I CAN USE THE SAME ONELOCUS AS FOR OTHERS

onelocus <- read.table('setting_L1.tsv')
onelocus <- FilterSetting(onelocus, 'logL', 1e-10)
onelocus <- GetReplicateAverages(onelocus, filter = 1)

multilocus_C1 <- read.table('setting_C1.tsv')
multilocus_C1 <- FillClosestS(multilocus_C1, onelocus)

multilocus_C5 <- read.table('setting_C5.tsv')
multilocus_C5 <- FillClosestS(multilocus_C5, onelocus)
# multilocus_C5$sss <- multilocus_C5$ss / multilocus_C5$s + rnorm(nrow(multilocus_C5), 0, 0.005)
# multilocus_C5$s_norm <- multilocus_C5$s + rnorm(nrow(multilocus_C5), 0, 0.007)

multilocus_C10 <- read.table('setting_C10.tsv')
multilocus_C10 <- FillClosestS(multilocus_C10, onelocus)

# multilocus_C20 <- read.table('../75_effects_of_drift/multilocus_D32_HM.tsv')
# multilocus_C20 <- FillClosestS(multilocus_C20, onelocus)

GradTable <- rbind(multilocus_C1, multilocus_C5, multilocus_C10, multilocus_C20)
GradTable$width[GradTable$width < 1] <- 1

#write.table(GradTable, 'filled_drift_GradTable.tsv')

### BETA
fillSss <- function(GradTable, filter){
  GradTable$width[GradTable$width < filter] <- NA
  GradTable$sss <- GradTable$ss / GradTable$s + rnorm(nrow(GradTable), 0, 0.005)
  GradTable$ss_norm <- GradTable$ss + rnorm(nrow(GradTable), 0, 0.005)
  GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)
  return(GradTable)
}

GradTable <- rbind(multilocus_C1, multilocus_C5, multilocus_C10, multilocus_C20)
GradTable <- fillSss(GradTable, 1)

tC_pal <- adjustcolor(brewer.pal(4,'Spectral'), 0.65)
C_pal <- adjustcolor(brewer.pal(4,'Spectral'), 0.65)
g_pal <- brewer.pal(6,'Reds')[-1]

for(beta in unique(GradTable$b)[1:3]){
  GradTable_subset <- GradTable[GradTable$b == beta,]
  pdf(paste0('sss_vs_sel_C_b',beta,'.pdf'))
    PlotStat(GradTable_subset, stat = 'sss', par1 = 's_norm', par2 = 'C',
             legend_position = 'topleft', pal = tC_pal, add = F,
             xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)',
             main = paste('beta', beta))
    PlotAverages(GradTable_subset, stat = 'sss', par1 = 's', par2 = 'C', pal = C_pal)
  dev.off()
}

for(beta in unique(GradTable$b)[4:5]){
  GradTable_subset <- GradTable[GradTable$b == beta,]
  pdf(paste0('sss_vs_sel_G_b',beta,'.pdf'))
    PlotStat(GradTable_subset, stat = 'sss', par1 = 's_norm', par2 = 'G',
             legend_position = 'topleft', pal = g_pal, add = F,
             xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)',
             main = paste('beta', beta))
    PlotAverages(GradTable_subset, stat = 'sss', par1 = 's', par2 = 'G', pal = g_pal)
  dev.off()
}

for(C in c(1,5,10,20)){
  GradTable_subset <- GradTable[GradTable$C == C,]
  number_of_betas <- length(unique(GradTable_subset$b))

  pdf(paste0('sss_vs_sel_b_C',C,'.pdf'))
    pal <- adjustcolor(brewer.pal(number_of_betas,'Set1'), 0.65)
    PlotStat(GradTable_subset, stat = 'sss', par1 = 's_norm', par2 = 'b',
             legend_position = 'topleft', pal = pal, add = F,
             xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)',
             main = paste(C, 'chromosomes'))
    pal <- brewer.pal(number_of_betas,'Set1')
    PlotAverages(GradTable_subset, stat = 'sss', par1 = 's', par2 = 'b', pal = pal)
  dev.off()

  pdf(paste0('ss_vs_sel_b_C',C,'.pdf'))
    pal <- adjustcolor(brewer.pal(number_of_betas,'Set1'), 0.65)
    PlotStat(GradTable_subset, stat = 'ss_norm', par1 = 's_norm', par2 = 'b',
             legend_position = 'topleft', pal = pal, add = F,
             xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)',
             main = paste(C, 'chromosomes'))
    pal <- brewer.pal(number_of_betas,'Set1')
    PlotAverages(GradTable_subset, stat = 'ss_norm', par1 = 's', par2 = 'b', pal = pal)
  dev.off()

  pdf(paste0('width_vs_G_C',C,'.pdf'))
    PlotBoxplots(GradTable_subset, 'width', 's', 'G', 'topright', pal = g_pal)
  dev.off()
}
