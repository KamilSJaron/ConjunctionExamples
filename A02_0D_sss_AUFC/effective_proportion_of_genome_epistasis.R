library(ConjunctionStats)

GradTable <- read.table('../A01_0D_sss/sss_0D_initial_search.tsv')

getStat <- function(df, stat){return(df[,stat])}

files <- c('epistasis_in_0D_really_weak_selection_and_epistasis','strong_s_no_b', 'stronger_s_little_b', 'stronger_s_relaxed_b')
for(file in files){
  sim <- ReadSummary(paste0(file,'.out'))
  GradTable_temp <- ReadSetting(paste0(file,'.txt'))
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
pdf('SYa_0D_edge.pdf')
  PlotStat(GradTable, 'sss', 's_norm', 'b', NA, xlab = 'selection + N(0, 0.005)',
           ylab = 's* / S ± sd', ylim = c(0,1.4), pal = pal_t, pch = 20)
  PlotAverages(GradTable, 'sss', 's', 'b', pal = pal, plot_sd = T, epsilon = 0.005)
  legend('topleft', legend = unique(GradTable$b),
         col = pal, pch = 20, bty = "n", title = expression(beta))
dev.off()

# PlotStat(GradTable, 'sss', 'b', 's', NA, xlab = 'b',
#          ylab = 's* / S', ylim = c(0,1.4), pal = pal_t, pch = 20)
# PlotAverages(GradTable, 'sss', 'b', 's', pal = pal, plot_sd = T, epsilon = 0.005)
# legend('topright', legend = unique(GradTable$b),
#        col = pal, pch = 20, bty = "n", title = expression(beta))

GradTable$AUFC <- 1 - GetAUFC(GradTable$s, GradTable$b)

pdf('2a_0D_AUFC.pdf')
  PlotAverages(GradTable, 'sss', 'AUFC', 'b',
               plot_sd = T, epsilon = 0.005, add = F, xlim = c(0.1, 1 - 0.23),
               ylim = c(0,1.2), xlab = '1 - AUFC', ylab = 's* / S ± sd', pal = pal)
  legend('bottomright', legend = unique(GradTable$b),
         col = pal, pch = 20, bty = "n", title = expression(beta))
dev.off()
