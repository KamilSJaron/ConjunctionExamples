library(ConjunctionStats)

sims <- ReadSummary('multilocus_cline.out')
sims <- ReadSummary('rep.out')
GradTable <- ReadSetting()

getStat <- function(df, stat){return(df[,stat])}
# GradTable$Pj <- unlist(lapply(sims, getStat, 'Material')) / unlist(lapply(sims, getStat, 'TotalBlocks'))
# GradTable$J <- unlist(lapply(sims, getStat, 'Population'))
# GradTable$JPj <- GradTable$Pj * GradTable$J

GradTable$JPj <- unlist(lapply(sims, getStat, 'Material'))

GradTable$M <- GradTable$D * (1 - GradTable$s)

GradTable$sss <- GradTable$M / (GradTable$s * GradTable$JPj)
GradTable$theta <- GradTable$s / GradTable$r
GradTable_means <- data.frame(theta = numeric(0), G = numeric(0), sss = numeric(0))
for (theta in unique(GradTable$theta)) {
    for (G in unique(GradTable$G)) {
        mw <- mean(GradTable$sss[GradTable$theta == theta & GradTable$G == G], na.rm = T)
        GradTable_means <- rbind(GradTable_means, data.frame(theta = theta,
            G = G, sss = mw))
    }
}

pdf('proportion_of_genome_vs_theta.pdf')
  pal <- brewer.pal(5,"RdYlBu")[c(-3)]
  x <- seq(1,4,by=0.01)
  y <- EquilG(x)
  plot(x,y, lwd = 1.5, lty = 2, type = 'l', xlim = c(0,4), ylim = c(0,1.2),
       xlab = expression(theta), ylab = expression('s* / S'))
  for(i in 1:4){
    points(sss ~ theta, subset = which(GradTable$G == GradTable$G[i]),
           data = GradTable, pch = 20, cex = 1, col = pal[i])
    lines(sss ~ theta, subset = which(GradTable$G == GradTable$G[i]),
          data = GradTable_means, col = pal[i])
  }
  legend('topleft', legend = unique(GradTable$G), col = pal, pch = 20)
dev.off()
