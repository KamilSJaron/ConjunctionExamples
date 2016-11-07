library(ConjunctionStats)
library(RColorBrewer)

GradTable <- read.table('sss_vs_AUFC.tsv')
#                   read.table('../75_effects_of_drift/one_locus_D32_HM.tsv')
# read.table('onelocus.tsv')
small_s <- read.table('../75_effects_of_drift/one_locus_D32_HM.tsv')
small_s <- small_s[small_s$s < 0.1,]
onelocus_HM_D32 <- rbind(read.table('onelocus.tsv'), small_s)
#GradTable <- GetReplicateAverages(GradTable)
onelocus_HM_D32 <- GetReplicateAverages(onelocus_HM_D32, 'one_locus_D32_HM_widths.pdf', filter = 1)
GradTable <- GradTable[GradTable$width_H > 1,]
GradTable <- FillClosestS(GradTable, onelocus_HM_D32)
GradTable$sss <- GradTable$ss / GradTable$s +
                         rnorm(nrow(GradTable), 0, 0.005)
GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)
GradTable$b_norm <- GradTable$b + rnorm(nrow(GradTable), 0, 0.007)

pdf('sss_vs_sel_beta.pdf')
  pal <- adjustcolor(brewer.pal(8,'Spectral'), 0.3)
  PlotStat(GradTable, stat = 'sss', par1 = 's_norm', par2 = 'b',
           legend_position = NA, pal = pal, add = F, ylim = c(0, 1.7),
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(8,'Spectral')
  PlotAverages(GradTable, 'sss', 's', 'b', pal)
  legend('topright', col = c(NA,pal), legend = c(expression(beta), unique(GradTable[,'b'])),
         pch = 20, horiz = T, cex = 0.785)
dev.off()

pdf('sss_vs_beta_s.pdf')
  pal <- adjustcolor(brewer.pal(8,'Spectral'), 0.3)
  PlotStat(GradTable, stat = 'sss', par1 = 'b_norm', par2 = 's',
           legend_position = NA, pal = pal, add = F,
           xlab = paste0(expression(beta),' + N(0,0.007)'), ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(8,'Spectral')
  PlotAverages(GradTable, 'sss', 'b', 's', pal)
  legend('topright', col = pal, legend = c(unique(GradTable[,'b'])),
         pch = 20, horiz = F, cex = 0.785, title = 'selection')
dev.off()

GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b +
                  rnorm(nrow(GradTable), 0, 0.008))
pdf('sss_vs_AUFC_beta.pdf')
  pal <- adjustcolor(brewer.pal(8,'Spectral'), 0.3)
  PlotStat(GradTable, stat = 'sss', par1 = 'AUFC',
           par2 = 'b', legend_position = F, pal = pal, add = F,
           xlab = 'AUFC + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  pal <- adjustcolor(brewer.pal(8,'Spectral'))
  GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b)
  PlotAverages(subset(GradTable, GradTable$G == 500), stat = 'sss',
               par1 = 'AUFC', par2 = 'b', pal = pal)
  legend('topright', col = pal, legend = unique(GradTable[,'b']),
         title = expression(beta), pch = 20)
dev.off()
