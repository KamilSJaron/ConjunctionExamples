library(ConjunctionStats)

#sigma^2 = 0.5, D=32
onelocus_1 <- read.table('../A05_1D_sss_under_drift/setting_onelocus_D32.tsv')
onelocus_2 <- read.table('setting_L1.tsv')
# onelocus_3 <- read.table('../N02_onelocus_clines_under_drift/setting_labda.tsv')
# onelocus_4 <- read.table('../N02_onelocus_clines_under_drift/setting_beta.tsv')

# onelocus_3$LogL <- NA
# onelocus_4$LogL <- NA

onelocus_1$run <- 1
onelocus_2$run <- 2
# onelocus_3$run <- 3
# onelocus_4$run <- 4

onelocus <- rbind(onelocus_1, onelocus_2) #, onelocus_3, onelocus_4)
PlotBoxplots(onelocus, 'width', 's', 'run', 'topright')
PlotBoxplots(onelocus, 'center', 's', 'run', 'topright')
