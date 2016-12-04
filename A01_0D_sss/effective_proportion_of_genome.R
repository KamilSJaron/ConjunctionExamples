library(ConjunctionStats)

sims <- append(ReadSummary('epistasis_in_0D.out'),
               ReadSummary('epistasis_in_0D_weak_selection.out'))
sims <- append(sims, ReadSummary('epistasis_in_0D_really_weak_selection.out'))

GradTable <- rbind(ReadSetting('epistasis_in_0D_weak_selection.txt'),
                   ReadSetting('epistasis_in_0D_really_weak_selection.txt'))

GradTable$n <- 1
GradTable <- rbind(ReadSetting('epistasis_in_0D.txt'), GradTable)

getStat <- function(df, stat){return(df[,stat])}
GradTable$JPj <- unlist(lapply(sims, getStat, 'Material'))

GradTable$sss <- (GradTable$D * (1 - GradTable$s)) / (GradTable$s * GradTable$JPj)
GradTable$theta <- GradTable$s / GradTable$r
GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.005)
GradTable <- GradTable[order(GradTable$b),]

write.table(GradTable, 'sss_0D_initial_search.tsv')

beta_pal <- colorRampPalette(brewer.pal(9,"Spectral"))(1000)

pal <- beta_pal[unique(GradTable$b) * 1000]
pal_t <- adjustcolor(pal, 0.3)

pdf('sss_no_phase_change.pdf')
  PlotStat(GradTable, 'sss', 's_norm', 'b', NA, xlab = 'selection + N(0, 0.005)',
           ylab = 's* / S', ylim = c(0,1.4), pal = pal_t, pch = 20)
  PlotAverages(GradTable, 'sss', 's', 'b', pal = pal, plot_sd = T, epsilon = 0.005)
  legend('bottomright', legend = unique(GradTable$b),
         col = pal, pch = 20, bty = "n", title = expression(beta))
dev.off()

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

pal <- brewer.pal(7, "PuBuGn")[-c(1,2)]
pal_t <- adjustcolor(pal, 0.3)
betas <- unique(GradTable_means$b)
for(beta in betas){
  SubTable <- GradTable[GradTable$b == beta,]
  pdf(paste0('mean_sss_vs_s_G_b',beta,'.pdf'))
    PlotStat(SubTable, 'sss', 's', 'G', NA, xlab = 'selection',
             ylab = 's* / S', ylim = c(0,1.4), pal = pal_t, pch = 20)
    PlotAverages(SubTable, 'sss', 's', 'G', pal = pal, plot_sd = F)
    legend('bottomright', legend = unique(GradTable$G),
           col = pal, pch = 20, bty = "n", title = 'Generation')
  dev.off()
}
