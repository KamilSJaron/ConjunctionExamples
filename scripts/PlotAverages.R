PlotAverages <- function(GradTable, stat, par1, par2, pal = NA, ...){
  if(any(is.na(pal))){
    pal <- brewer.pal(length(unique(GradTable[,par2])), 'Set1')
  }
  for(par_state in unique(GradTable[,par2])){
    col <- pal[which(par_state == unique(GradTable[,par2]))]
    SubTable <- subset(GradTable, GradTable[,par2] == par_state)
    lines(tapply(SubTable[,stat],
          SubTable[,par1], mean) ~ sort(unique(SubTable[,par1])), col = col, ...)
    points(tapply(SubTable[,stat],
           SubTable[,par1], mean) ~ sort(unique(SubTable[,par1])),
           col = col, pch = 20)
  }
}
