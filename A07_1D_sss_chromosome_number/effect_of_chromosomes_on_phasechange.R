library(ConjunctionStats)
library(RColorBrewer)

onelocus <- read.table('setting_L1.tsv')
onelocus <- GetReplicateAverages(onelocus, filter = 1)

GradTable <- read.table('../A05_1D_sss_under_drift/setting_D32_HM.tsv')
GradTable <- FillClosestS(GradTable, onelocus)

for(C in c('C10', 'C5', 'C1')){
  multilocus <- read.table(paste0('setting_',C,'.tsv'))
  GradTable <- rbind(GradTable, FillClosestS(multilocus, onelocus))
}

GradTable <- FillSss(GradTable)

#write.table(GradTable, 'filled_drift_GradTable.tsv')
tC_pal <- adjustcolor(brewer.pal(4,'Spectral'), 0.65)
C_pal <- brewer.pal(4,'Spectral')
g_pal <- brewer.pal(6,'Reds')[-1]

for(beta in unique(GradTable$b)[1:3]){
  GradTable_subset <- GradTable[GradTable$b == beta,]
  pdf(paste0('sss_vs_sel_C_b',beta,'.pdf'))
    PlotStat(GradTable_subset, stat = 'sss_norm', par1 = 's_norm', par2 = 'C',
             legend_position = 'topleft', pal = tC_pal, add = F,
             xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)',
             main = paste('beta', beta))
    PlotAverages(GradTable_subset, stat = 'sss_norm', par1 = 's', par2 = 'C', pal = C_pal)
  dev.off()
}

for(beta in unique(GradTable$b)[4:5]){
  GradTable_subset <- GradTable[GradTable$b == beta,]
  pdf(paste0('sss_vs_sel_G_b',beta,'.pdf'))
    PlotStat(GradTable_subset, stat = 'sss_norm', par1 = 's_norm', par2 = 'G',
             legend_position = 'topleft', pal = g_pal, add = F,
             xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)',
             main = paste('beta', beta))
    PlotAverages(GradTable_subset, stat = 'sss_norm', par1 = 's', par2 = 'G', pal = g_pal)
  dev.off()
}

pal <- brewer.pal(5,'Set1')

for(C in c(1,5,10,20)){
  GradTable_subset <- GradTable[GradTable$C == C,]
  number_of_betas <- length(unique(GradTable_subset$b))

  t_beta_pal <- adjustcolor(pal, 0.65)[(6 - number_of_betas):5]
  beta_pal <- pal[(6 - number_of_betas):5]

  pdf(paste0('sss_vs_sel_b_C',C,'.pdf'))
    PlotStat(GradTable_subset, stat = 'sss_norm', par1 = 's_norm', par2 = 'b',
             legend_position = 'topleft', pal = t_beta_pal, add = F,
             xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)',
             main = paste(C, 'chromosomes'))
    PlotAverages(GradTable_subset, stat = 'sss_norm', par1 = 's', par2 = 'b', pal = beta_pal)
  dev.off()

  pdf(paste0('ss_vs_sel_b_C',C,'.pdf'))
    PlotStat(GradTable_subset, stat = 'ss_norm', par1 = 's_norm', par2 = 'b',
             legend_position = 'topleft', pal = t_beta_pal, add = F,
             xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)',
             main = paste(C, 'chromosomes'))
    PlotAverages(GradTable_subset, stat = 'ss_norm', par1 = 's', par2 = 'b', pal = beta_pal)
  dev.off()

  pdf(paste0('width_vs_G_C',C,'.pdf'))
    PlotBoxplots(GradTable_subset, 'width', 's', 'G', 'topright', pal = g_pal)
  dev.off()
}

pdf(paste0('sss_vs_sel_b_C.pdf'), width = 8)
  pal_names <- c('RdPu', 'BuGn', 'PuBu', 'YlOrBr')
  ref_cols <- c()

  plot(numeric(0), xlim = c(0,0.8), ylim = c(0,1.3),
       xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.006)')

  for(C in c(1,5,10,20)){
    GradTable_subset <- GradTable[GradTable$C == C,]
    number_of_betas <- length(unique(GradTable_subset$b))

    beta_pal <- brewer.pal(number_of_betas + 2, pal_names[C == c(1,5,10,20)])[3:(number_of_betas + 2)]
    ref_cols <- c(ref_cols, beta_pal[number_of_betas-1])
    t_beta_pal <- adjustcolor(beta_pal, 0.65)

    PlotStat(GradTable_subset, stat = 'sss_norm', par1 = 's_norm', par2 = 'b',
             legend_position = NA, pal = t_beta_pal, add = T)
    PlotAverages(GradTable_subset, stat = 'sss_norm', par1 = 's', par2 = 'b', pal = beta_pal)
  }
  legend(0.07 , 1.3, sort(unique(GradTable$b), decreasing = T),
         title = expression(beta), pch = 20, bty = "n", col = brewer.pal(7, 'Greys')[3:7])
  legend(0.2, 1.3, c(1,5,10,20), title = 'C', pch = 20, col = ref_cols, bty = "n")
dev.off()
