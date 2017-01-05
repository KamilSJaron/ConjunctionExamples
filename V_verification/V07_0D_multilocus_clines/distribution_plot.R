library(ConjunctionStats)
library(RColorBrewer)

GradTable <- ReadSetting('setting.txt')

GradTable$theta <- GradTable$s / GradTable$r

for(s in unique(GradTable$s)){
  GradTable_subset <- GradTable[GradTable$s == s,]
  pdf(paste0('theta',GradTable_subset$theta[1],'.pdf'))
    plot(c(),xlab='ln(y)', ylab=expression(paste('ln(',psi,'(y))',sep='')),
         xlim=c(-16,0),ylim=c(0,20),cex.lab=1.5, cex.axis=1.5,
         main = paste(expression(theta),GradTable_subset$theta[1]))

    order = which(s == unique(GradTable$s))
    if(order < 10){
      pattern <- paste0('0d_out_s0',order,'_')
    } else {
      pattern <- paste0('0d_out_s',order,'_')
    }
    for(i in 1:3){
      blocks <- read.csv(paste0(pattern, i ,'.tsv'), header = F)
      PlotBLockDistr(blocks,GradTable_subset[i,], ceil = 2500)
    }

    x <- (log((7/8)^c(0:100)) + log((7/8)^(1:101))) / 2
    eqy <- log(BlocksDistribution(exp(x),s,0.2,100 * (1 - s)))
    lines(x,eqy)
    pal <- colorRampPalette(brewer.pal(9,"PuBuGn"))(2500)

    legend( -16.2, 8.2,
            legend=c("theoretical distr.", "", "simulated distr.",
              "833 generations", "1666 generations", "2500 generations"),
            lwd=1.2, lty=c(1,NA,NA,1,1,1),col=c(1,1,1,pal[c(633,1666,2500)]),
            pch=c(NA,NA,NA,20,20,20), cex = 1.7)

  dev.off()
}
