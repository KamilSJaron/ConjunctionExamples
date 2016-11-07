library(ConjunctionStats)
library(RColorBrewer)

GradTable_L1 <- read.table('one_locus_widths.tsv')
#GradTable_L1 <- read.table('../75_effects_of_drift/one_locus_D32_LM.tsv')
GradTable_L1 <- GetReplicateAverages(GradTable_L1)

GradTable <- rbind(read.table('many_loci_widths.tsv'), read.table('multilocus.tsv'))
GradTable <- FillClosestS(GradTable, GradTable_L1)

GradTable$sss <- GradTable$ss / GradTable$s + rnorm(nrow(GradTable), 0, 0.005)
GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)

pal <- adjustcolor(brewer.pal(3,'RdYlGn'), 0.3)

pdf('sss_vs_sel_beta_hmean.pdf')
  PlotStat(GradTable, stat = 'sss', par1 = 's_norm', par2 = 'b',
           legend_position = 'bottomright', pal = pal,
           xlab = 's* / S')
  pal <- brewer.pal(3,'RdYlGn')
  PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'b', pal = pal, lwd = 2)
dev.off()

#GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b)

#pdf('sss_agains_1L_equivalent.pdf')
#PlotStat(GradTable, stat = 'sss', par1 = 'AUFC', par2 = 'b',
#         legend_position = 'topright', pal = pal)
#dev.off()

hmean <- function(x){
  length(x) / sum(1 / x)
}
