library(ConjunctionStats)
library(RColorBrewer)

GradTable_L1 <- read.table('one_locus_widths.tsv')
source('../75_effects_of_drift/filling_functions.R')
GradTable_L1 <- read.table('../75_effects_of_drift/one_locus_D32_LM.tsv')
GradTable_L1 <- getReplicateAverages(GradTable_L1)

GradTable <- rbind(read.table('many_loci_widths.tsv'), read.table('multilocus.tsv'))
#GradTable <- fillClosestS(GradTable, onelocus_HM_D32)

nthroot <- function(a,b) ifelse( b %% 2 == 1 | a >= 0, sign(a)*abs(a)^(1/b), NaN)

gmean <- function(x){
  nthroot(prod(x), length(x))
}

hmean <- function(x){
  length(x) / sum(1 / x)
}

GradTable_L20k_means <- data.frame(s = numeric(0),
                                    b = numeric(0),
                                    width_H = numeric(0),
                                    closest_1L_s = numeric(0))
for(sel in unique(GradTable$s)){
  for(beta in unique(GradTable$b)){
    # mean because some valuas do not converge in first 100 generations,
    # so I wanted to take a meansure with takes into account outlayers
    slopes <- 1 / GradTable$width_H[GradTable$s == sel & GradTable$b == beta]
    mw <- 1 / hmean(slopes)
    cs <- GradTable_L1$s[which.min(abs(GradTable_L1$width_H - mw))]
    GradTable_L20k_means <- rbind(GradTable_L20k_means,
                                   data.frame(s = sel,
                                              b = beta,
                                              width_H = mw,
                                              closest_1L_s = cs))
  }
}

GradTable_L20k_means$sss <- GradTable_L20k_means$closest_1L_s / GradTable_L20k_means$s

GradTable$ss <- NA
for(l in 1:nrow(GradTable)){
  ss <- GradTable_L1$s[which.min(abs(GradTable_L1$width_H - GradTable$width_H[l]))]
  GradTable$ss[l] <- ss
}

GradTable$sss <- GradTable$ss / GradTable$s + rnorm(nrow(GradTable), 0, 0.005)
GradTable$s_n <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)

source('../scripts/add_alpha.R')
add.alpha(brewer.pal(3,'RdYlGn'), 0.3)

pdf('sss_vs_sel_beta_hmean.pdf')
  PlotStat(GradTable, stat = 'sss', par1 = 's_n', par2 = 'b',
           legend_position = 'bottomright', pal = pal,
           xlab = 's* / S')
  pal <- brewer.pal(3,'RdYlGn')
  for(beta in 1:3){
    GTb <- GradTable_L20k_means[GradTable_L20k_means$b == unique(GradTable_L20k_means$b)[beta],]
    GTb <- GTb[order(GTb$s),]
    lines(GTb$sss ~ GTb$s, lwd = 3, col = pal[beta])
  }
dev.off()

#GradTable$AUFC <- getAUFC(GradTable$s, GradTable$b)

#pdf('sss_agains_1L_equivalent.pdf')
#PlotStat(GradTable, stat = 'sss', par1 = 'AUFC', par2 = 'b',
#         legend_position = 'topright', pal = pal)
#dev.off()
