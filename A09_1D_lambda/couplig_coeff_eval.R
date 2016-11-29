library(ConjunctionStats)
library(RColorBrewer)
library(nlme)

onelocus <- read.table('../A07_1D_sss_chromosome_number/setting_L1.tsv')
onelocus <- GetReplicateAverages(onelocus, filter = 1)

GradTable <- data.frame()

for(C in c('C20','C10', 'C5', 'C1')){
  multilocus <- read.table(paste0('setting_',C,'.tsv'))
  GradTable <- rbind(GradTable, FillClosestS(multilocus, onelocus))
}
GradTable <- FillSss(GradTable)

pdf(paste0('sss_vs_sel_C_lambda.pdf'), width = 8)
  pal_names <- c('RdPu', 'BuGn', 'PuBu', 'YlOrBr')
  ref_cols <- c()

  plot(numeric(0), xlim = c(0.58,0.82), ylim = c(0,1.4),
       xlab = 's + N(0,0.007)', ylab = '(s* / S) + N(0,0.006)')

  for(C in c(1,5,10,20)){
    GradTable_subset <- GradTable[GradTable$C == C,]
    number_of_r <- length(unique(GradTable_subset$r))
    beta_pal <- brewer.pal(number_of_r + 2, pal_names[C == c(1,5,10,20)])[3:(number_of_r + 2)]
    ref_cols <- c(ref_cols, beta_pal[number_of_r-1])
    t_beta_pal <- adjustcolor(beta_pal, 0.35)

    PlotStat(GradTable_subset, stat = 'sss_norm', par1 = 's_norm', par2 = 'r',
             legend_position = NA, pal = t_beta_pal, add = T)
  }

  for(C in c(1,5,10,20)){
    GradTable_subset <- GradTable[GradTable$C == C,]
    number_of_r <- length(unique(GradTable_subset$r))
    beta_pal <- brewer.pal(number_of_r + 2, pal_names[C == c(1,5,10,20)])[3:(number_of_r + 2)]
    PlotAverages(GradTable_subset, stat = 'sss_norm', par1 = 's', par2 = 'r', pal = beta_pal, lwd = 1.3)
  }
  legend(0.7 , 0.4, sort(unique(GradTable$b), decreasing = T),
         title = expression(lambda), pch = 20, bty = "n", col = brewer.pal(6, 'Greys')[3:7])
  legend(0.76, 0.4, c(1,5,10,20), title = 'C', pch = 20, col = ref_cols, bty = "n")
dev.off()

GradTable$AUFC <- GetAUFC(GradTable$s, GradTable$b)
GradTable$AUFC_norm <- GradTable$AUFC + rnorm(nrow(GradTable), 0, 0.005)

pdf(paste0('sss_vs_AUFC_C_lambda.pdf'), width = 8)
  pal_names <- c('RdPu', 'BuGn', 'PuBu', 'YlOrBr')
  ref_cols <- c()

  plot(numeric(0), xlim = c(min(GradTable$AUFC_norm),max(GradTable$AUFC_norm)),
       ylim = c(0,1.4), xlab = 'AUFC + N(0,0.005)', ylab = '(s* / S) + N(0,0.006)')

  for(C in c(1,5,10,20)){
    GradTable_subset <- GradTable[GradTable$C == C,]
    number_of_r <- length(unique(GradTable_subset$r))
    beta_pal <- brewer.pal(number_of_r + 2, pal_names[C == c(1,5,10,20)])[3:(number_of_r + 2)]
    ref_cols <- c(ref_cols, beta_pal[number_of_r-1])
    t_beta_pal <- adjustcolor(beta_pal, 0.35)

    PlotStat(GradTable_subset, stat = 'sss_norm', par1 = 'AUFC_norm', par2 = 'r',
             legend_position = NA, pal = t_beta_pal, add = T)
  }

  for(C in c(1,5,10,20)){
    GradTable_subset <- GradTable[GradTable$C == C,]
    number_of_r <- length(unique(GradTable_subset$r))
    beta_pal <- brewer.pal(number_of_r + 2, pal_names[C == c(1,5,10,20)])[3:(number_of_r + 2)]
    PlotAverages(GradTable_subset, stat = 'sss', par1 = 'AUFC', par2 = 'r', pal = beta_pal, lwd = 1.3)
  }
  legend(0.25 , 0.4, unique(GradTable$r),
         title = expression(lambda), pch = 20, bty = "n", col = brewer.pal(6, 'Greys')[3:7])
  legend(0.29, 0.4, c(1,5,10,20), title = 'C', pch = 20, col = ref_cols, bty = "n")
dev.off()

# simplified_theta_model <- lm(sss ~ s + b + s * b + C + r + r * C, data = GradTable)
#
# GradTable$sss <- round(GradTable$sss)
# theta_model <- glm(sss ~ AUFC,
#                    family=binomial(link='logit'), data = GradTable)
