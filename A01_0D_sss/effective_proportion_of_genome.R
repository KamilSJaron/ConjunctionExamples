library(ConjunctionStats)

sims <- append(ReadSummary('epistasis_in_0D.out'), ReadSummary('epistasis_in_0D_weak_selection.out'))

GradTable <- ReadSetting('epistasis_in_0D_weak_selection.txt')
GradTable$n <- 1
GradTable <- rbind(ReadSetting('epistasis_in_0D.txt'), GradTable)

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

pdf('0D_sss_vs_selection_beta.pdf')
  PlotStat(GradTable_means, 'sss', 's', 'b', 'bottomright', xlab = 'selection',
           ylab = 's* / S')
dev.off()
