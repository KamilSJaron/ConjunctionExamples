library(ConjunctionStats)
library(sys)

args <- ...

GradTable <- ReadSetting(args[1])
sim <- ReadSummary(args[2])
GradTable <- FillSettingByHZAR(sim, GradTable)

write.table(GradTable, args[3])
