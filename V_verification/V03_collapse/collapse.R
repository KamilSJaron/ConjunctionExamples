library(ConjunctionStats)

GradTable <- ReadSetting('sims/rotation.txt')
sims <- ReadSummary('sims/rotation.out')
GradTable <- FillSetting(sims, GradTable, 'nlm')

png('./figures/width_over_time_wo_selection_nlm.png')
  plot(GradTable$width ~ GradTable$G, pch = 20, ylim = c(0,max(GradTable$width, na.rm = T)), xlab = 'generation', ylab = 'cline width')
  x <- seq(0,100,0.01)
  lines(sqrt(2 * pi * 0.5 * seq(0,100,by = 0.1)) ~ seq(0,100,by = 0.1), col = 'red')
dev.off()

GradTable <- read.table('sims/rotation.tsv')

png('./figures/width_over_time_wo_selection_hzar.png')
  plot(GradTable$width ~ GradTable$G, pch = 20, ylim = c(0,max(GradTable$width, na.rm = T)), xlab = 'generation', ylab = 'cline width')
  x <- seq(0,100,0.01)
  lines(sqrt(2 * pi * 0.5 * seq(0,100,by = 0.1)) ~ seq(0,100,by = 0.1), col = 'red')
dev.off()
