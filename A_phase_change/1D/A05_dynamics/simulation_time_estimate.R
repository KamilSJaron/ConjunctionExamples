time <- read.table('./dynamics/time')$V1
#[1:400]

plot(time, pch = 20, ylab = 'time (s)')

order <- 1:length(time)

basic <- lm(time ~ order)
quadratic <- lm(time ~ order + I(order^2))
cubic <- lm(time ~ order + I(order^2) + I(order^3))
full <- lm(time ~ order + I(order^2) + I(order^3) + I(order^4))
# overfull <- lm(time ~ order + I(order^2) + I(order^3) + I(order^4) + I(order^5))
# lessoverfull <- lm(time ~ order + I(order^2) + I(order^3) + I(order^5))

# summary(basic)
summary(quadratic)
# summary(cubic)
#
# anova(basic, quadratic)
# anova(cubic, quadratic)
# anova(cubic, full)
# anova(overfull, full)

newdata <- data.frame(order = 1:10000)
newdata$time <- as.vector(predict(full, newdata))
newdata$time_of_sim <- cumsum(newdata$time)

plot(cumsum(time), pch = 20, ylab = 'time (s)')
# , xlim = c(1,10000), ylim = c(0, max(newdata$time_of_sim)))
lines(1:10000, newdata$time_of_sim)

newdata$time_of_sim_hours <- newdata$time_of_sim / 3600
which.min(abs(newdata$time_of_sim_hours - 128))
# 1706 - a week
