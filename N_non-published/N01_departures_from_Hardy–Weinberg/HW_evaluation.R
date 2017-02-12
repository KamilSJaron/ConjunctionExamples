library(ConjunctionStats)

GradTable <- ReadSetting()
sim <- ReadSummary('HW.out')

getAB <- function(onesim){
  return(onesim[,'f(heter)'])
}

getB <- function(onesim){
  return(onesim[,'meanHI'])
}

# compute number of AA, AB and BB individuals
GradTable$A <- 1 - unlist(lapply(sim, getB))
GradTable$B <- 1 - GradTable$A
ab_freq <- unlist(lapply(sim, getAB))

GradTable$AA <- (((2 * GradTable$A) - ab_freq) / 2)
GradTable$AB <- ab_freq
GradTable$BB <- (((2 * GradTable$B) - ab_freq) / 2)

GradTable$AB_exp <- GradTable$A * GradTable$B  * 2
GradTable$AA_exp <- GradTable$A * GradTable$A
GradTable$BB_exp <- GradTable$B * GradTable$B

GradTable$departure <- abs(GradTable$AA - GradTable$AA_exp) +
                       abs(GradTable$AB - GradTable$AB_exp) +
                       abs(GradTable$BB - GradTable$BB_exp)

pdf('relation_HW_demesize.pdf')
  plot(GradTable$departure ~ GradTable$D,
       pch = 20,
       xlab = expression(paste(log[2],' population size')),
       ylab = 'departure from HW',
       log='x')
dev.off()

# introducing sampling (I will draw 8 random individuals per simualtion)
GradTable$sampled_AA <- 0
GradTable$sampled_AB <- 0
GradTable$sampled_BB <- 0

for(i in 1:nrow(GradTable)){
  haplotypes <- c(rep('AA',round(GradTable$AA[i] * GradTable$D[i])),
  rep('AB',round(GradTable$AB[i] * GradTable$D[i])),
  rep('BB',round(GradTable$BB[i] * GradTable$D[i])))
  shaplotypes <- sample(haplotypes, 8, replace=F)
  GradTable$sampled_AA[i] <- mean(shaplotypes == 'AA')
  GradTable$sampled_AB[i] <- mean(shaplotypes == 'AB')
  GradTable$sampled_BB[i] <- mean(shaplotypes == 'BB')
}

GradTable$sampled_A <- GradTable$sampled_AA + GradTable$sampled_AB / 2
GradTable$sampled_B <- GradTable$sampled_BB + GradTable$sampled_AB / 2

GradTable$sampled_AB_exp <- GradTable$sampled_A * GradTable$sampled_B  * 2
GradTable$sampled_AA_exp <- GradTable$sampled_A * GradTable$sampled_A
GradTable$sampled_BB_exp <- GradTable$sampled_B * GradTable$sampled_B

GradTable$sampled_departure <- abs(GradTable$sampled_AA - GradTable$sampled_AA_exp) +
                       abs(GradTable$sampled_AB - GradTable$sampled_AB_exp) +
                       abs(GradTable$sampled_BB - GradTable$sampled_BB_exp)

pdf('relation_HW_demesize_with_sampling.pdf')
  plot(GradTable$sampled_departure ~ GradTable$D,
       pch = 20,
       xlab = expression(paste(log[2],' population size')),
       ylab = 'departure from HW in 8 sampled individuals',
       log='x')
dev.off()
