library(ConjunctionStats)

onelocus <- read.table('../A05_1D_sss_under_drift/setting_onelocus_D32.tsv')
onelocus <- GetReplicateAverages(onelocus, filter = 1)

GradTable <- read.table('setting_init.tsv')
GradTable_zoomed <- read.table('setting_zoom.tsv')
GradTable <- rbind(GradTable, GradTable_zoomed)
GradTable <- FillClosestS(GradTable, onelocus)
GradTable <- FillSss(GradTable)

pdf('2b_1D_edge.pdf')
  pal <- brewer.pal( length(unique(GradTable$b)) ,'Spectral')
  t_pal <- adjustcolor(pal, 0.35)
  PlotStat(GradTable, stat = 'sss_norm', par1 = 's_norm', par2 = 'b',
           legend_position = 'topleft', pal = pal, add = F,
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  PlotAverages(GradTable, stat = 'sss', par1 = 's', par2 = 'b', pal = pal)
dev.off()
