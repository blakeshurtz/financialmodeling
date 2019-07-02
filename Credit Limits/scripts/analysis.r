###plot distribution of bc_util
hist(acceptedcomplete$bc_util, breaks=40)
sum(acceptedcomplete$bc_util > 100)
sum(acceptedcomplete$bc_util > 100)/nrow(acceptedcomplete)

#create new variable: bc_open_bal
bc_open_bal <- acceptedcomplete$total_bc_limit * acceptedcomplete$bc_util/100
hist(bc_open_bal)

#visualize the two
plot(bc_open_bal/1000, acceptedcomplete$total_bc_limit/1000)
abline(a = 0, b = 1)
