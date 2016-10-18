library(ConjunctionStats)
library(RColorBrewer)

GradTable <- ReadSetting()
sim <- ReadSummary('sss_vs_theta_for_limited_L.out')
GradTable <- FillSettingByHZAR(sim, GradTable)

L1 <- GradTable[GradTable$L == 1,]
dict <- data.frame(s = numeric(0), width_H = numeric(0))
for(sel in unique(L1$s)){
  dict <- rbind(dict, data.frame(s = sel, width_H = mean(L1$width_H[L1$s == sel])))
}

source('../75_effects_of_drift/filling_functions.R')

GradTable <- fillClosestS(GradTable, dict)
GradTable$theta <- (GradTable$s / GradTable$r) + rnorm(nrow(GradTable),0,0.05)
GradTable$sss <- (GradTable$ss / GradTable$s) + rnorm(nrow(GradTable),0,0.05)

pal <- brewer.pal(4, 'Spectral')

pdf('sss_vs_theta_and_L.pdf')
  plot(numeric(0), xlim = c(0,4), ylim = c(0,1.2), xlab = expression(theta), ylab = "s* / S")
  for(L in unique(GradTable$L)){
      Lo <- which(L == unique(GradTable$L))
      col <- pal[Lo]
      toPlot <- GradTable[GradTable$L == L,]
      points(toPlot$sss ~ toPlot$theta, pch = 20, col = col)
  }
  legend(0,0.25, legend = paste0('L',c(100,10,2,1)), pch = 20, col = pal)
dev.off()
