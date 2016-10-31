library(ConjunctionStats)

GradTable <- read.table('width_estimates.tsv')

source('../75_effects_of_drift/filling_functions.R')
onelocus_HM_D32 <- read.table('../75_effects_of_drift/one_locus_D32_LM.tsv')
#onelocus_HM_D32 <- getReplicateAverages(onelocus_HM_D32)
#GradTable <- fillClosestS(GradTable, onelocus_HM_D32)

getSmooth <- function(GradTable, ainit = 2, depth = 1){
  out <- tryCatch(
    {
      y = GradTable$width_H
      x = GradTable$s
      # width = (fact * sigma) / sqrt(s)
      fitModel = nls(y ~ (a / sqrt(x)) - b * sqrt(x),
                      start = list(a = ainit, b = 0))
      return(coefficients(fitModel))
    },
    error=function(cond) {
      if(depth > 256){
        return(NA)
      } else {
        return(getSmooth(GradTable, ainit - 0.02, depth+1))
      }
    }
  )
  return(out)
}

pars <- getSmooth(onelocus_HM_D32)

x <- seq(0,1,by = 0.01)
y <- (pars[1] / sqrt(x)) - pars[2] * sqrt(x)

GradTable <- fillClosestS(GradTable, data.frame(s = x, width_H = y))
GradTable$sss <- GradTable$ss / GradTable$s

GradTable$s <- GradTable$s + rnorm(nrow(GradTable), 0, 0.007)

source('../scripts/add_alpha.R')

pdf('smooth_sss_vs_sel_beta.pdf')
  nbetas <- length(unique(GradTable$b))
  pal <- add.alpha(brewer.pal(nbetas,'Spectral')[1], 0.65)
  for(i in 2:nbetas){
      pal <- c(pal, add.alpha(brewer.pal(nbetas,'Spectral')[i], 0.65))
  }
  PlotStat(GradTable, stat = 'sss', par1 = 's', par2 = 'b',
           legend_position = 'bottomright', pal = pal, add = F,
           xlab = 's + N(0,0.007)', ylab = '(s* / S)')
dev.off()
