library(ConjunctionStats)

sims <- append(ReadSummary('epistasis_in_0D.out'),
               ReadSummary('epistasis_in_0D_weak_selection.out'))
sims <- append(sims, ReadSummary('epistasis_in_0D_really_weak_selection.out'))
sims <- append(sims, ReadSummary('epistasis_in_0D_really_weak_selection_and_epistasis.out'))

GradTable <- rbind(ReadSetting('epistasis_in_0D_weak_selection.txt'),
                   ReadSetting('epistasis_in_0D_really_weak_selection.txt'))

GradTable$n <- 1
GradTable <- rbind(ReadSetting('epistasis_in_0D.txt'), GradTable,
                   ReadSetting('epistasis_in_0D_really_weak_selection_and_epistasis.txt'))

getStat <- function(df, stat){return(df[,stat])}
GradTable$JPj <- unlist(lapply(sims, getStat, 'Material'))

GradTable$sss <- (GradTable$D * (1 - GradTable$s)) / (GradTable$s * GradTable$JPj)
GradTable$theta <- GradTable$s / GradTable$r
GradTable_means <- data.frame(s = numeric(0), b = numeric(0), G = numeric(0), sss = numeric(0))
for (s in unique(GradTable$s)) {
  for (b in unique(GradTable$b)){
    for (G in unique(GradTable$G)) {
        mw <- mean(GradTable$sss[GradTable$s == s & GradTable$G == G & GradTable$b == b], na.rm = T)
        GradTable_means <- rbind(GradTable_means, data.frame(s = s, b = b,
                                 G = G, sss = mw))
    }
  }
}

GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.005)
GradTable <- GradTable[order(GradTable$b),]
pal <- brewer.pal(5, "Set1")
pal_t <- adjustcolor(pal, 0.2)
pdf('2a_0D_edge.pdf')
  PlotStat(GradTable, 'sss', 's_norm', 'b', NA, xlab = 'selection + N(0, 0.005)',
           ylab = 's* / S', ylim = c(0,1.4), pal = pal_t, pch = 20)
  PlotAverages(GradTable, 'sss', 's', 'b', pal = pal, plot_sd = T, epsilon = 0.005)
  legend('bottomright', legend = unique(GradTable$b),
         col = pal, pch = 20, bty = "n", title = expression(beta))
dev.off()

#cards <- c('2660', '2663', '2665', '2666')
#pchs <- (15:18,-0x25B2, -0x2663)
GradTable$AUFC <- GetAUFC(GradTable$s, GradTable$b)

pdf('SY_0D_AUFC.pdf')
  PlotAverages(GradTable, 'sss', 'AUFC', 'b',
               plot_sd = T, epsilon = 0.005, add = F, xlim = c(0.23,0.9),
               ylim = c(0,1.2), xlab = 'AUFC', ylab = 's* / S')
  legend('bottomleft', legend = unique(GradTable$b),
         col = pal, pch = 20, bty = "n", title = expression(beta))
dev.off()
