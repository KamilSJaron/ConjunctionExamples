files_to_read <- read.table('list_of_1D_sims')
files_to_read <- as.character(files_to_read$V1)

GradTable <- data.frame()

for(file in files_to_read){
  gradtab <- read.table(file)[,c('G','C','r','s','b','sss')]
  GradTable <- rbind(GradTable, gradtab)
}
