library(ConjunctionStats)
library(RColorBrewer)

small_s <- read.table('../A04_1D_sss/setting_onelocus_D32.tsv')
small_s <- small_s[small_s$s < 0.1,]
onelocus_HM_D32 <- rbind(read.table('onelocus.tsv'), small_s)
onelocus_HM_D32 <- GetReplicateAverages(onelocus_HM_D32, 'one_locus_D32_HM_widths.pdf', filter = 1)

GradTable <- read.table('sss_vs_AUFC.tsv')
GradTable <- GradTable[GradTable$LogL > -100 & GradTable$width > 1,]
GradTable <- FillClosestS(GradTable, onelocus_HM_D32)
GradTable$sss <- GradTable$ss / GradTable$s +
                         rnorm(nrow(GradTable), 0, 0.005)
GradTable$s_norm <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)
GradTable$b_norm <- GradTable$b + rnorm(nrow(GradTable), 0, 0.007)

pdf('sss_vs_sel_beta.pdf')
  pal <- adjustcolor(brewer.pal(8,'Spectral'), 0.3)
  PlotStat(GradTable, stat = 'sss', par1 = 's_norm', par2 = 'b',
           legend_position = NA, pal = pal, add = F, ylim = c(0, 1.7),
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(8,'Spectral')
  PlotAverages(GradTable, 'sss', 's', 'b', pal)
  legend('topright', col = c(NA,pal), legend = c(expression(beta), unique(GradTable[,'b'])),
         pch = 20, horiz = T, cex = 0.785, bty = "n")
dev.off()

pdf('sss_vs_beta_s.pdf')
  pal <- adjustcolor(brewer.pal(8,'Spectral'), 0.3)
  PlotStat(GradTable, stat = 'sss', par1 = 'b_norm', par2 = 's',
           legend_position = NA, pal = pal, add = F, bty = "n",
           xlab = paste0(expression(beta),' + N(0,0.007)'), ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(8,'Spectral')
  PlotAverages(GradTable, 'sss', 'b', 's', pal)
  legend('topright', col = pal, legend = c(unique(GradTable[,'b'])),
         pch = 20, horiz = F, cex = 0.785, title = 'selection')
dev.off()

GradTable$AUFC <- GetAUFC(GradTable$s, GradTable$b)
GradTable$AUFC_norm <- GradTable$AUFC + rnorm(nrow(GradTable), 0, 0.002)

stat = 'sss'
par1 = 'AUFC_norm'
par2 = 'b'
par3 = 's'

#cards <- c('2660', '2663', '2665', '2666')
#shapes <- c('25B2','25BC','25CF')

pdf('sss_vs_AUFC_points.pdf')
  pal <- brewer.pal(8,'Spectral')
  t_pal <- adjustcolor(pal, 0.5)

  xlim = c(min(GradTable[, par1]), max(GradTable[, par1]))
  ylim = c(min(GradTable[, stat], na.rm = T), max(GradTable[, stat], na.rm = T))

  plot(numeric(0), xlim = xlim, ylim = ylim, xlab = 'AUFC + N(0,0.002)',
       ylab = 's* / s + N(0,0.005)')

  for (par_state in unique(GradTable[, par2])) {
    col <- pal[which(par_state == unique(GradTable[, par2]))]
    t_col <- t_pal[which(par_state == unique(GradTable[, par2]))]
    for (par3_state in unique(GradTable[, par3])){
      pch <- 6 + which(par3_state == unique(GradTable[, par3]))

      SubTable <- subset(GradTable, GradTable[, par2] == par_state &
                                    GradTable[, par3] == par3_state)
      points(SubTable[, par1], SubTable[, stat], col = t_col, pch = pch)
      points(tapply(SubTable[, stat], SubTable[, 'AUFC'], mean) ~
             sort(unique(SubTable[, 'AUFC'])), col = col, pch = 20, cex = 1.5)
    }
    SubTable <- subset(GradTable, GradTable[, par2] == par_state)
    lines(tapply(SubTable[, stat], SubTable[, 'AUFC'], mean) ~
          sort(unique(SubTable[, 'AUFC'])), col = col, lwd = 2)
  }
  legend(0.52, 1.55, col = pal, legend = unique(GradTable[,'b']),
         title = expression(beta), pch = 20, bty = "n")
  legend(0.46, 1.55, col = 1, legend = rev(unique(GradTable[,'s'])),
        title = 'sel', pch = rev(seq(7, by = 1, length = 8)), bty = "n")
dev.off()

pdf('SYb_1D_AUFC.pdf')
  pal <- brewer.pal(8,'Spectral')
  t_pal <- adjustcolor(pal, 0.5)

  xlim <- c(min(GradTable[, par1]), max(GradTable[, par1]))
  ylim <- c(min(GradTable[, stat], na.rm = T) - 0.02, max(GradTable[, stat], na.rm = T))
  epsilon <- 0.005

  plot(numeric(0), xlim = xlim, ylim = ylim, xlab = 'AUFC + N(0,0.002)',
       ylab = 's* / s + N(0,0.005)')

  betas <- unique(GradTable$b)
  selections <- unique(GradTable$s)

  for (sel in selections) {
    col <- pal[which(sel == selections)]
    t_col <- adjustcolor(col, 0.5)
    for (beta in betas){
      pch <- 6 + which(beta == betas)
      SubTable <- subset(GradTable, GradTable$s == sel &
                                    GradTable$b == beta)
      x <- unique(SubTable$AUFC)
      y <- mean(SubTable$sss)
      sd <- sd(SubTable$sss)
      points(x, y, col = col, pch = pch)
      segments(x, y-sd, x, y+sd, col = col)
      segments(x-epsilon, y-sd, x + epsilon, y-sd, col = col)
      segments(x-epsilon, y+sd, x + epsilon, y+sd, col = col)
    }
    SubTable <- subset(GradTable, GradTable$s == sel)
    y <- tapply(SubTable$sss, SubTable$AUFC, mean)
    x <- as.numeric(names(y))
    sd <- tapply(SubTable$sss, SubTable$AUFC, sd)
    lines(x, y, col = col, lwd = 1.5)
  }
  legend(0.52, 1.55, col = pal, legend = unique(GradTable[,'b']),
         title = expression(beta), pch = 20, bty = "n")
  legend(0.46, 1.55, col = 1, legend = rev(unique(GradTable[,'s'])),
        title = 'sel', pch = rev(seq(7, by = 1, length = 8)), bty = "n")
dev.off()

library(ggplot2)

pdf('width_distributions_vs_s.pdf')
  GradTable_b3 <- GradTable[GradTable$b == unique(GradTable$b)[3],]
  GradTable_b3$s <- as.factor(GradTable_b3$s)
  hist_cut <- ggplot(GradTable_b3, aes(x=width, fill=s))
  hist_cut + geom_density(alpha = 0.4)
dev.off()

# GradTable$sb <- factor(paste0('s',GradTable$s,'b',GradTable$b))
# hist_cut <- ggplot(GradTable, aes(x=width, fill=sb))
# hist_cut + geom_density(alpha = 0.2)
