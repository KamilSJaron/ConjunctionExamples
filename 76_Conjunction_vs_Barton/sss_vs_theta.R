library(ConjunctionStats)
library(RColorBrewer)

#GradTable <- ReadSetting()
#sim <- ReadSummary('sss_vs_theta_for_limited_L_rep.out')
#GradTable <- FillSettingByHZAR(sim, GradTable)
#write.table(GradTable, 'sss_vs_theta_widths.tsv')
GradTable <- read.table('sss_vs_theta_widths.tsv')

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

L <- 100
plot(numeric(0), xlim = c(0,4), ylim = c(0,1.2), xlab = expression(theta), ylab = "s* / S")
col <- pal[which(L == unique(GradTable$L))]
points(sss ~ theta, pch = 20, col = col, data = GradTable[GradTable$L == L,])

summary(GradTable[GradTable$L == L & GradTable$sss > 0.8, ])
summary(GradTable[GradTable$L == L & GradTable$sss < 0.4, ])

pdf('widths_vs_s_L.pdf')
#PlotBoxplotStat
stat <- 'width_H'
par1 <- 's'
par2 <- 'L'
xlim = c(min(GradTable[, par1]), max(GradTable[, par1]))
ylim = c(min(GradTable[, stat], na.rm = T), max(GradTable[,
            stat], na.rm = T))

bins <- length(unique(GradTable[, par2])) + 1
step <- min(diff(sort(unique(GradTable[, par1])))) / bins
box_width <- diff(xlim) / ((length(unique(GradTable[, par1])) + 1) *
                           length(unique(GradTable[, par2])))
pal <- brewer.pal(length(unique(GradTable[, par2])), "Set1")
plot(numeric(0), xlim = xlim + c(-step,step), ylim = c(0,15)) # add ylim, ...

for(p1 in unique(GradTable[, par1])){
  for(p2 in unique(GradTable[, par2])){
    p2_order <- which(p2 == unique(GradTable[, par2]))
    p1_at <- p1 - (((bins / 2) - p2_order) * step)
    boxplot(GradTable[GradTable[, par2] == p2 & GradTable[, par1] == p1, stat],
            at = p1_at,
            boxwex = box_width,
            add = T,
            col = pal[p2_order])
  }
}
dev.off()

pdf('widths_vs_s_L.pdf')
#PlotBoxplotStat
stat <- 'width_H'
par1 <- 's'
par2 <- 'L'
xlim = c(min(GradTable[, par1]), max(GradTable[, par1]))
ylim = c(min(GradTable[, stat], na.rm = T), max(GradTable[,
            stat], na.rm = T))

bins <- length(unique(GradTable[, par2])) + 1
step <- min(diff(sort(unique(GradTable[, par1])))) / bins
box_width <- diff(xlim) / ((length(unique(GradTable[, par1])) + 1) *
                           length(unique(GradTable[, par2])))
pal <- brewer.pal(length(unique(GradTable[, par2])), "Set1")
plot(numeric(0), xlim = xlim + c(-step,step), ylim = c(0,15), xlab = 's', ylab = 'width_H') # add ylim, ...

for(p1 in unique(GradTable[, par1])){
  for(p2 in unique(GradTable[, par2])){
    p2_order <- which(p2 == unique(GradTable[, par2]))
    p1_at <- p1 - (((bins / 2) - p2_order) * step)
    boxplot(GradTable[GradTable[, par2] == p2 & GradTable[, par1] == p1, stat],
            at = p1_at,
            boxwex = box_width,
            add = T,
            col = pal[p2_order])
  }
}
legend('bottomleft', col = pal, legend = unique(GradTable[, par2]), pch = 20, title = par2)
dev.off()

pdf('widths_vs_s_L_zoomed.pdf')
#PlotBoxplotStat
stat <- 'width_H'
par1 <- 's'
par2 <- 'L'
xlim = c(min(GradTable[, par1]), max(GradTable[, par1]))
ylim = c(min(GradTable[, stat], na.rm = T), max(GradTable[,
            stat], na.rm = T))

bins <- length(unique(GradTable[, par2])) + 1
step <- min(diff(sort(unique(GradTable[, par1])))) / bins
box_width <- diff(xlim) / ((length(unique(GradTable[, par1])) + 1) *
                           length(unique(GradTable[, par2])))
pal <- brewer.pal(length(unique(GradTable[, par2])), "Set1")
plot(numeric(0), xlim = xlim + c(-step,step), ylim = c(1.5,5), xlab = 's', ylab = 'width_H') # add ylim, ...

for(p1 in unique(GradTable[, par1])){
  for(p2 in unique(GradTable[, par2])){
    p2_order <- which(p2 == unique(GradTable[, par2]))
    p1_at <- p1 - (((bins / 2) - p2_order) * step)
    boxplot(GradTable[GradTable[, par2] == p2 & GradTable[, par1] == p1, stat],
            at = p1_at,
            boxwex = box_width,
            add = T,
            col = pal[p2_order])
  }
}
legend('bottomleft', col = pal, legend = unique(GradTable[, par2]), pch = 20, title = par2)

dev.off()
