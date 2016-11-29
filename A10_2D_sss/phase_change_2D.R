library(ConjunctionStats)
library(RColorBrewer)

####### Analysis of 2D estimates

# harmonic mean has mostly negligible effect, however in some instances up to 5
# max(z1,z2) is suprisingly conservative, but i do not want to use it since we do not know
# how wrong estimates are for wider zones

# proposed workflow: z1 < filter -> NA
# if(z1 is NA and z2 > 1, replace NA by z2)
# take (method(z1)) as 2D width estimate

GradTable <- read.table("multilocus_setting_2D.tsv")
GradTable <- Fill2DMean(GradTable, 'width', filter = 1, method = hmean)
GradTable <- Fill2DMean(GradTable, 'center', filter = 0, method = mean)

GradTable_onelocus <- read.table("onelocus_setting_2D.tsv")
GradTable_onelocus <- Fill2DMean(GradTable_onelocus, 'width', filter = 1, method = hmean)

pdf('number_of_demes_vs_width.pdf', width = 8, height = 4)
  par(mfrow = c(1, 2))
  plot(GradTable_onelocus$width ~ GradTable_onelocus$total_demes, main = 'onelocus',
       pch = 20, xlab = 'total number of demes',
       ylim = c(min(GradTable$width), max(GradTable$width)),
       ylab = 'harmonic mean of widths greater than one', cex = 0.3)
  plot(GradTable$width ~ GradTable$total_demes, main = 'multilocus',
       pch = 20, xlab = 'total number of demes', ylab = '', cex = 0.3)
  #points(GradTable$width ~ GradTable$total_demes, pch = 20, col = 'red', cex = 0.3,subset = GradTable$width < 3.3 & GradTable$total_demes > 250)
dev.off()

pdf('deviation_of_width_all.pdf', width = 8, height = 4)
  par(mfrow = c(1, 2))
  Plot2DZone(GradTable, pal = rainbow(5))
  Plot2DZone(GradTable_onelocus, pal = rainbow(14))
  title('width_i - mean(width), without filtering', outer=TRUE, line = -3)
dev.off()

GradTable <- FilterSetting(GradTable, 'width_', 1)
GradTable_onelocus <- FilterSetting(GradTable_onelocus, 'width_', 1)

pdf('deviation_of_width_filt.pdf', width = 8, height = 4)
  par(mfrow = c(1, 2))
  Plot2DZone(GradTable, pal = rainbow(5))
  Plot2DZone(GradTable_onelocus, pal = rainbow(14))
  title('width_i - mean(width), with filtering', outer = T, line = -3)
dev.off()

pdf('widths2D_fil.pdf')
  Plot2DZone(GradTable, center = F)
dev.off()

GradTable$width_norm <- GradTable$width + rnorm(nrow(GradTable), 0, 0.007)
selection_width_dictionary <- GetReplicateAverages(GradTable_onelocus)
GradTable <- FillClosestS(GradTable, selection_width_dictionary)
GradTable <- FillSss(GradTable)

pdf('hmean_width_vs_selection.pdf')
  PlotStat(GradTable, 'width_norm', 's_norm', 'b', ylab = 'mean width', xlab = 'selection')
dev.off()

pdf('2c_2D_edge.pdf')
  pal <- adjustcolor(brewer.pal(4,'Spectral'), 0.5)[-3]
  PlotStat(GradTable, stat = 'sss_norm', par1 = 's_norm', par2 = 'b',
           legend_position = NA, pal = pal, add = F, ylim = c(0, 1.3),
           xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.005)')
  pal <- brewer.pal(4,'Spectral')[-3]
  PlotAverages(GradTable, 'sss_norm', 's', 'b', pal)
  legend('bottomright', col = c(NA,pal), legend = c(expression(beta), unique(GradTable[,'b'])),
         pch = 20, horiz = T, cex = 0.785)
dev.off()

# sim_multilocus <- ReadSummary('multilocus_setting_2D.out')
# sim_onelocus <- ReadSummary('onelocus_setting_2D.out')
# selections_of_sim <- (read.table('onelocus_selections.tsv')$V1)
# fixed_order <- order(rep(selections_of_sim, each = 10), decreasing=F)
#
# GetHeterozygoteDemes <- function(onesim){
#   return(sum(onesim[,'f(heter)'] > 0))
# }
#
# GetHeterozygoteIndividualsFreq <- function(onesim){
#   # total number of heterozygotes will be this number * total number of demes * demesize
#   return(mean(onesim[, 'f(heter)']))
# }
#
# FillHeterozygotes <- function(GradTable, sim){
#   GradTable$number_of_het_ind <- unlist(lapply(sim, GetHeterozygoteIndividualsFreq)) *
#                                  GradTable$D * GradTable$total_demes
#   GradTable$number_of_het_demes <- unlist(lapply(sim, GetHeterozygoteDemes))
#   return(GradTable)
# }
#
# GradTable <- FillHeterozygotes(GradTable, sim_multilocus)
# GradTable_onelocus$number_of_het_ind <- unlist(lapply(sim_onelocus, GetHeterozygoteIndividualsFreq))[fixed_order] *
#                                GradTable_onelocus$D * GradTable_onelocus$total_demes
# GradTable_onelocus$number_of_het_demes <- unlist(lapply(sim_onelocus, GetHeterozygoteDemes))[fixed_order]
#
# pdf('number_of_het_demes_vs_width.pdf', width = 8, height = 4)
#   par(mfrow = c(1, 2))
#   plot(GradTable_onelocus$width ~ GradTable_onelocus$number_of_het_demes, main = 'onelocus',
#        pch = 20, xlab = 'number of heterozygotious demes',
#        ylim = c(min(GradTable$width), max(GradTable$width)),
#        ylab = 'harmonic mean of widths greater than one', cex = 0.3)
#   plot(GradTable$width ~ GradTable$number_of_het_demes, main = 'multilocus',
#        pch = 20, xlab = 'number of heterozygotious demes', ylab = '', cex = 0.3)
# dev.off()
#
# pdf('number_of_het_individuals_vs_width.pdf', width = 8, height = 4)
#   par(mfrow = c(1, 2))
#   plot(GradTable_onelocus$width ~ GradTable_onelocus$number_of_het_ind, main = 'onelocus',
#        pch = 20, xlab = 'total number of heterozygotes',
#        ylim = c(min(GradTable$width), max(GradTable$width)),
#        ylab = 'harmonic mean of widths greater than one', cex = 0.3)
#   plot(GradTable$width ~ GradTable$number_of_het_ind, main = 'multilocus',
#        pch = 20, xlab = 'total number of heterozygotes', ylab = '', cex = 0.3)
# dev.off()
