library(ConjunctionStats)

#dir('epistasis', pattern='txt', full.names=T)
settings <- dir('sims', pattern='txt', full.names=T)
sims <-  dir('sims', pattern='out', full.names=T)

#GradTable <- read.table('../A01_0D_sss/sss_0D_initial_search.tsv')
GradTable <- data.frame()

getStat <- function(df, stat){return(df[,stat])}

#files <- c('epistasis_in_0D_really_weak_selection_and_epistasis','strong_s_no_b', 'stronger_s_little_b', 'stronger_s_relaxed_b')
for(index in 1:length(settings)){
  sim <- ReadSummary(sims[index])
  GradTable_temp <- ReadSetting(settings[index])
  GradTable_temp$JPj <- unlist(lapply(sim, getStat, 'Material'))
  GradTable_temp$sss <- (GradTable_temp$D * (1 - GradTable_temp$s)) / (GradTable_temp$s * GradTable_temp$JPj)
  GradTable_temp$theta <- GradTable_temp$s / GradTable_temp$r
  GradTable_temp$s_norm <- GradTable_temp$s + rnorm(nrow(GradTable_temp), 0, 0.005)
  GradTable <- rbind(GradTable, GradTable_temp)
}

GradTable <- GradTable[order(GradTable$b),]

beta_pal <- colorRampPalette(brewer.pal(9,"Spectral"))(38)

pal <- beta_pal[round(log(unique(GradTable$b)*10) * 10) + 15]
pal_t <- adjustcolor(pal, 0.3)
for(C in c(1,5,10,20)){
  GradTable_Ctemp <- GradTable[GradTable$C == C,]
  for(lambda in unique(GradTable_Ctemp$r)){
      GradTable_temp <- GradTable_Ctemp[GradTable_Ctemp$r == lambda,]
      pdf(paste0('0D_sss_C',C,'_lambda',lambda,'.pdf'))
        PlotStat(GradTable_temp, 'sss', 's_norm', 'b', NA,
                 xlab = 'selection + N(0, 0.005)',
                 ylab = 's* / S ± sd', ylim = c(0,1.4), pal = pal_t, pch = 20,
                 main = paste("C", C, ", lambda", lambda))
        PlotAverages(GradTable_temp, 'sss', 's', 'b', pal = pal, plot_sd = T, epsilon = 0.005)
        legend('topleft', legend = unique(GradTable_temp$b),
               col = pal[1:length(unique(GradTable_temp$b))],
               pch = 20, bty = "n", title = expression(beta))
      dev.off()
  }
}

# PlotStat(GradTable, 'sss', 'b', 's', NA, xlab = 'b',
#          ylab = 's* / S', ylim = c(0,1.4), pal = pal_t, pch = 20)
# PlotAverages(GradTable, 'sss', 'b', 's', pal = pal, plot_sd = T, epsilon = 0.005)
# legend('topright', legend = unique(GradTable$b),
#        col = pal, pch = 20, bty = "n", title = expression(beta))
