library('RColorBrewer')
library('ConjunctionStats')

# contains 90 saves of three simulations
ld_sum_loci <- ReadSummary('out_l')
# contains 30 saves if one simulation
ld_sum_chrom <- ReadSummary('out_c')

# function will be used for easy extraction of one column from list of data frames (summaries)
getLD <- function(df){
	return(df$LD)
}

# make a data frame of all LDs
LDs <- data.frame(generation = 1:30)
LDs$indipendent <- unlist(lapply(ld_sum_chrom, getLD))
# just by checking setting_L we see order of lambdas
LDs$l_0_25 <- unlist(lapply(ld_sum_loci, getLD))[1:30]
LDs$l_0_5 <- unlist(lapply(ld_sum_loci, getLD))[31:60]
LDs$l_3 <- unlist(lapply(ld_sum_loci, getLD))[61:90]


# theoretical prediction
x <- 1:30
eq <- function(x,r){
	return(0.25 * (1 - r) ^ (x - 1))
}

# prepare a colour palette
pal <- brewer.pal(11,"PRGn")

# The link between parameter lambda and recombination rate is explained in
# the [Conjunction wiki](https://github.com/KamilSJaron/Conjunction/wiki/Individual)

pdf('LD_decay.pdf')
	plot(c(), pch = 17, col = pal[2], xlim = c(1,30) , ylim = c(-6,-1.4), xlab = "Generation", ylab = 'ln(LD)',cex.lab=1.1, cex.axis=1.1)
	points(log(LDs$l_0_25), pch = 17, col = pal[8], cex = 1.3)
	lines(x, log(eq(x, 0.19793)), col = pal[8])
 	points(log(LDs$l_0_5), pch = 17, col = pal[9], cex = 1.3)
 	lines(x, log(eq(x, 0.3160914)), col = pal[9])
	points(log(LDs$l_3), pch = 16, col = pal[10], cex = 1.3)
	lines(x, log(eq(x, 0.5)), col = pal[10])
	points(log(LDs$indipendent), pch = 17, col = pal[10], cex = 1.3)
	legend(20.2, -1.32, c(0.19,0.31,0.5), col = pal[c(8,9,10)], pch = 17, title = expression('r'),cex=1.2)
	legend(25.4, -1.32, c("2     1","1     2"), pch = c(16, 17), title = '     C     L',cex=1.2)
dev.off()
