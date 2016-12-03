library(ConjunctionStats)

onelocus <- read.table('setting_onelocus_D32.tsv')
onelocus <- GetReplicateAverages(onelocus, filter = 1)

GradTable <- read.table('setting_D32.tsv')
GradTable <- FillClosestS(GradTable, onelocus)
GradTable <- FillSss(GradTable)

GradTable <- GradTable[order(GradTable$b),]

pal <- brewer.pal( length(unique(GradTable$b)) ,'Spectral')
t_pal <- adjustcolor(pal, 0.35)

pdf('1D_edge_points.pdf')
  PlotStat(GradTable, stat = 'sss_norm', par1 = 's_norm', par2 = 'b',
           legend_position = 'topleft', pal = pal, add = F,
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'b', pal = pal)
dev.off()

pdf('2b_1D_edge.pdf')
  PlotAverages(GradTable, 'sss', 's', 'b',
               plot_sd = T, epsilon = 0.005,
               add = F, xlab = 's', ylab = 'mean s* / S ± sd', pal = pal)
  legend('bottomright', legend = unique(GradTable$b),
         col = pal, pch = 20, bty = "n", title = expression(beta))
dev.off()


GradTable$AUFC <- GetAUFC(GradTable$s, GradTable$b)

pdf('SX_1D_edge_points.pdf')
  PlotAverages(GradTable, 'sss', 'AUFC', 'b',
               plot_sd = T, epsilon = 0.005,
               add = F, xlab = 'AUFC', ylab = 's* / S', pal = pal)
  legend('bottomleft', legend = unique(GradTable$b),
         col = pal, pch = 20, bty = "n", title = expression(beta))
dev.off()
