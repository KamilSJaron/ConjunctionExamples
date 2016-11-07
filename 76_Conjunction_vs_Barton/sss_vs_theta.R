library(ConjunctionStats)
library(RColorBrewer)

#GradTable <- ReadSetting()
#sim <- ReadSummary('sss_vs_theta_for_limited_L_rep.out')
#GradTable <- FillSettingByHZAR(sim, GradTable)
#write.table(GradTable, 'sss_vs_theta_widths.tsv')
GradTable <- read.table('sss_vs_theta_widths.tsv')
GradTable <- GradTable[GradTable$width_H > 1,]

pdf('widths_vs_s_L.pdf')
  PlotBoxplots(GradTable, 'width_H', 's', 'L', 'topright')
dev.off()

pdf('widths_vs_s_L_zoomed.pdf')
  PlotBoxplots(GradTable, 'width_H', 's', 'L', 'bottomleft', ylim = c(1.5,5))
dev.off()

# with better replicates
L1 <- read.table('../79_onelocus_drift/setting_D.tsv')
L1 <- L1[L1$D == 256,]
L1 <- GetReplicateAverages(L1, filter = 1)
L1 <- rbind(L1[L1$s < 0.2 | L1$s > 0.85, ],
            GetReplicateAverages(GradTable[GradTable$L == 1,], filter = 1))

GradTable <- FillClosestS(GradTable, L1)

GradTable$sss <- (GradTable$ss / GradTable$s) + rnorm(nrow(GradTable),0,0.05)

pdf('sss_vs_theta_loci.pdf')
  GradTable$theta <- (GradTable$s / GradTable$r) + rnorm(nrow(GradTable),0,0.05)
  pal <- adjustcolor(brewer.pal(4,'Spectral'), 0.3)
  PlotStat(GradTable, stat = 'sss', par1 = 'theta', par2 = 'L',
           legend_position = NA, pal = pal, add = F,
           xlab = paste0(expression(beta),' + N(0,0.007)'), ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(4,'Spectral')
  GradTable$theta <- (GradTable$s / GradTable$r)
  PlotAverages(GradTable, 'sss', 'theta', 'L', pal)
  legend('topright', col = pal, legend = c(unique(GradTable[,'L'])),
         pch = 20, horiz = F, cex = 0.785, title = 'loci')
dev.off()


L100 <- GradTable[GradTable$L == 100,]
pdf('L100_generation.pdf')
  pal <- adjustcolor(brewer.pal(5,'Spectral'))
  PlotStat(L100, 'sss', 's', 'G', 'topleft')
  PlotAverages(L100, 'sss', 's', 'G', pal)
dev.off()

#PlotBoxplots(L100, 'sss', 's', 'G', 'topleft')
