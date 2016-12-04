epis <- function(x,beta,s){
# x, beta, selection
# x and s is in range 0,1
# reasonable betas are 1/16 to 16
  y <- 1 - (s * (4 * x * (1 - x))^beta)
  return(y)
}

b <- unique(read.table('sss_vs_AUFC.tsv')$b)
s <- c(0.90, 0.90, 0.86, 0.86, 0.82, 0.82, 0.78, 0.78)

pal <- brewer.pal(8, "Spectral")
x <- seq(0,1,by=0.01)
pdf('./edge_non_collapsing_fitness_functions.pdf')
  plot(numeric(0),xlim=c(0,1),ylim=c(0,1),xlab='hybrid index',ylab='fitness',col='red')
  for(i in 1:8){
    lines(epis(x, b[i] , s[i]) ~ x, col = pal[i])
  }
  legend('top', paste(s,b, sep = '  '), pch = 20, col = pal, bty = "n",
  title=expression(paste('   s    ',beta)), title.adj=0.2)
dev.off()
