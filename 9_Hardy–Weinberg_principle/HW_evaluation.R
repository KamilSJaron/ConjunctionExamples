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
