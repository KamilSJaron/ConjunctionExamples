library(ConjunctionStats)

# load simulations with dispersal 0.25 (LM = low migration)
GradTable_LM <- ReadSetting('setting_introblocks_LM.txt')
sim_LM <- ReadSummary('introblocks_LM.out')
GradTable_LM <- FillSetting(sim_LM,GradTable_LM)

# load simulations with dispersal 0.5 (HM = high migration)
GradTable_HM <- ReadSetting('setting_introblocks_HM.txt')
sim_HM <- ReadSummary('introblocks_HM.out')
GradTable_HM <- FillSetting(sim_HM,GradTable_HM)

# seems that in this case the effect of Deme size to deme width is negligible
#PlotWidths(GradTable_HM[GradTable_HM$s == 0.4 & GradTable_HM$b == 1,],
#           'G', 'D', 'bottomright', pal = c('green', 'purple'), ylim = c(1,20))
#PlotWidths(GradTable_LM[GradTable_LM$s == 0.4 & GradTable_LM$b == 1,],
#           'G', 'D', 'topleft', add = T)

# same here
#PlotWidths(GradTable_LM[GradTable_LM$G == 400 & GradTable_LM$b == 1,],
#           's', 'D')

# effective selection acting over the whole genome (s* in Barton 83)
GradTable_HM$Ss <- 8 * 0.5 / GradTable_HM$width_l^2
GradTable_LM$Ss <- 8 * 0.25 / GradTable_LM$width_l^2

# effective proportion of genome acting together as a fraction of effective selection in total selection
GradTable_HM$sss <- GradTable_HM$Ss / GradTable_HM$s
GradTable_LM$sss <- GradTable_LM$Ss / GradTable_LM$s

# the test of consistency of dispersal 0.25 and 0.5, when meaningless values are discarded
t.test(GradTable_HM$sss[which(GradTable_HM$sss < 1 & GradTable_LM$sss < 1)] /
       GradTable_LM$sss[which(GradTable_HM$sss < 1 & GradTable_LM$sss < 1)],
       mu = 1)

# obviously wrong for strong selection
GradTable_HM[which(GradTable_HM$sss > 1),]

# cut dataset only for meaningful values of sss
selection <- which(GradTable_HM$sss < 1 & GradTable_LM$sss < 1)
GradTable_HM <- GradTable_HM[selection,]
GradTable_LM <- GradTable_LM[selection,]

trendline <- lm(GradTable_HM$sss ~ GradTable_HM$s)
pdf('proportion_of_genome_vs_selection.pdf')
  plot(GradTable_HM$sss ~ GradTable_HM$s, pch = 20)
  points(GradTable_LM$sss ~ GradTable_LM$s, pch = 20, col = 'red')
  abline(trendline)
dev.off()

trendline <- lm(GradTable_HM$sss ~ GradTable_HM$b)
pdf('proportion_of_genome_vs_beta.pdf')
  plot(GradTable_HM$sss ~ GradTable_HM$b, pch = 20)
  points(GradTable_LM$sss ~ GradTable_LM$b, pch = 20, col = 'red')
  abline(trendline)
dev.off()

trendline <- lm(GradTable_HM$sss ~ GradTable_HM$G)
pdf('proportion_of_genome_vs_generation.pdf')
  plot(GradTable_HM$sss ~ GradTable_HM$G, pch = 20)
  points(GradTable_LM$sss ~ GradTable_LM$G, pch = 20, col = 'red')
  abline(trendline)
dev.off()

trendline <- lm(GradTable_HM$sss ~ GradTable_HM$D)
pdf('proportion_of_genome_vs_deme_size.pdf')
  plot(GradTable_HM$sss ~ GradTable_HM$D, pch = 20)
  points(GradTable_LM$sss ~ GradTable_LM$D, pch = 20, col = 'red')
  abline(trendline)
dev.off()
