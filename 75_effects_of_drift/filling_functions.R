
fillClosestS <- function(multilocus, onelocus){
  multilocus$ss <- NA
  for(line in 1:nrow(multilocus)){
    ss <- onelocus$s[which.min(abs(onelocus$width_H - multilocus$width_H[line]))]
    multilocus$ss[line] <- ss
  }
  return(multilocus)
}

getReplicateAverages <- function(GradTable, filename = NA, G = NA){
  # GradTable - filled GradTable
  # filename - name of pdf for boxplot, default, no plot
  # G - subset of GradTable using generation

  if(!is.na(G)){
    GradTable <- GradTable[GradTable$G == G,]
  }

  if(!is.na(filename)){
    pdf('widths_vs_selection_L1.pdf')
    x <-seq(0,1,by=0.01)

    plot(x,twidth(x,sqrt(0.5)), type = 'l',
         ylim = c(min(GradTable$width_H), max(GradTable$width_H)),
         xlim = c(min(GradTable$s), max(GradTable$s)),
         xlab = 'selection', ylab = 'width_H')
  }

  GradTable_means <- data.frame(s = numeric(0),
                                b = numeric(0),
                                width_H = numeric(0))

  for(sel in unique(GradTable$s)){
    for(beta in unique(GradTable$b)){
      mw <- mean(GradTable$width_H[GradTable$s == sel & GradTable$b == beta])
      GradTable_means <- rbind(GradTable_means,
                               data.frame(s = sel,
                                          b = beta,
                                          width_H = mw))
      if(!is.na(filename)){
        boxplot(GradTable$width_H[GradTable$s == sel],
                at = sel,
                boxwex = 0.05,
                add = T)
      }
    }
  }

  if(!is.na(filename)){
    dev.off()
  }

  return(GradTable_means)
}
