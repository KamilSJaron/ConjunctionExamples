library(ConjunctionStats)
library(RColorBrewer)

#GradTable <- ReadSetting()
#sim <- ReadSummary('sss_vs_theta_for_limited_L_rep.out')
#GradTable <- FillSettingByHZAR(sim, GradTable)
#write.table(GradTable, 'sss_vs_theta_widths.tsv')
GradTable <- read.table('sss_vs_theta_for_limited_L.tsv')
GradTable <- rbind(GradTable, read.table('./L100_long/setting_L100_long.tsv'))
GradTable <- GradTable[GradTable$width > 1,]
GradTable <- GradTable[GradTable$LogL > -200,]
GradTable <- GradTable[GradTable$D == 128,]

pdf('widths_vs_s_L.pdf')
  PlotBoxplots(GradTable, 'width', 's', 'L', 'topright')
dev.off()

pdf('widths_vs_s_L_zoomed.pdf')
  PlotBoxplots(GradTable, 'width', 's', 'L', 'bottomleft', ylim = c(1.5,5))
dev.off()

# with better replicates
L1 <- read.table('../A05_1D_sss_under_drift/setting_onelocus_D128.tsv')
L1 <- GetReplicateAverages(L1, filter = 1)

GradTable <- FillClosestS(GradTable, L1)

GradTable$sss <- (GradTable$ss / GradTable$s) + rnorm(nrow(GradTable),0,0.05)

pdf('sss_vs_theta_loci.pdf')
  GradTable$theta <- (GradTable$s / GradTable$r) + rnorm(nrow(GradTable),0,0.05)
  pal <- adjustcolor(brewer.pal(4,'Spectral'), 0.3)
  PlotStat(GradTable, stat = 'sss', par1 = 'theta', par2 = 'L',
           legend_position = NA, pal = pal, add = F,
           xlab = paste0(expression(theta),' + N(0,0.007)'), ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(4,'Spectral')
  GradTable$theta <- (GradTable$s / GradTable$r)
  PlotAverages(GradTable, 'sss', 'theta', 'L', pal)
  legend('topright', col = pal, legend = c(unique(GradTable[,'L'])),
         pch = 20, horiz = F, cex = 0.785, title = 'loci')
dev.off()


pdf('L100_generation.pdf')
  beta_pal <- colorRampPalette(brewer.pal(9,"Spectral"))(1000)[seq(50,1000,by = 50)]
  PlotStat(GradTable, 'sss', 's', 'G', NA, pal = beta_pal)
  PlotAverages(GradTable, 'sss', 's', 'G', beta_pal)
  legend('topleft', legend = seq(200, 1000, by = 200), col = beta_pal[seq(form = 4, by = 4, length = 5)], pch = 20)
dev.off()

#PlotBoxplots(L100, 'sss', 's', 'G', 'bottomleft')
