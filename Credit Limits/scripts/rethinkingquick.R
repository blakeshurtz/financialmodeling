library(rethinking)

approval <- c(rep(0, 50), rep(1, 50))
set.seed(1234); credit_reject <- rnorm(50, mean = 70, sd = 10); hist(credit_reject)
set.seed(2345); credit_accept <- rnorm(50, mean = 90, sd = 10); hist(credit_accept)
credit <- c(credit_reject, credit_accept)
d <- cbind(approval, credit); d <- as.data.frame(d)
colnames(d) <- c("approval", "credit")
str(d)

#linear model
l_model <- lm(approval ~ credit, data=d)
summary(l_model)

#stan model- normal prior
b_model <- ulam(
  alist(
    approval ~ dnorm( mu , sigma ) ,
    mu <- b_0 + b_1*credit,
    b_0 ~ dnorm( 0 , 2 ) ,
    b_1 ~ dnorm( 0 , 1 ) ,
    sigma ~ dexp( 1 )
  ) ,
  data=d , chains=1, cores=4 , iter=1000 )

precis(b_model)

#stan model- weighted prior
b_model_weighted <- ulam(
  alist(
    approval ~ dnorm( mu , sigma ) ,
    mu <- b_0 + b_1*credit,
    b_0 ~ dnorm( 0 , 2 ) ,
    b_1 ~ dnorm( -100000 , 1 ) ,
    sigma ~ dexp( 1 )
  ) ,
  data=d , chains=1, cores=4 , iter=1000 )

precis(b_model_weighted)
