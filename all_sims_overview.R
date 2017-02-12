library(ConjunctionStats)

setting_list <- as.character(unlist(read.table('list_of_settings.dat')))

# just heler function
PlotParametersOfMultipleSims <- function(file, pattern){
#  path <- '/Volumes/dump/pictures/pool/hybrid_zones/Conjunction/'
  path = './'
  settings <- setting_list[grep(pattern, setting_list)]
  # remove onelocus simulations, relying on naming convention I introduced
  settings <- settings[grep('one', settings, invert = T)]
  GradTable <- data.frame()

  for(setting in settings){
    GradTable <- rbind(GradTable, ReadSetting(setting)[,c('s','b','r','C')])
  }

  GradTable$b[GradTable$b < 1/16] <- 1/16

  pdf(paste0(path, file), width=16, height=4)
    PlotParametricSpace(GradTable, cex = 3)
  dev.off()
}

PlotParametersOfMultipleSims('parameters_0D.pdf', 'A0._0')
PlotParametersOfMultipleSims('parameters_1D.pdf', 'A0._1')
PlotParametersOfMultipleSims('parameters_2D.pdf', 'multilocus_setting_2D')
PlotParametersOfMultipleSims('parameters_edge.pdf', '5000')
