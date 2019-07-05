library(rethinking)

approval <- c(rep(1, 50), rep(0, 50))
#data from accepted loans (we have this)
set.seed(1234); credit_accept <- rnorm(50, mean = 100, sd = 10); hist(credit_accept)
default_accept <- ifelse(credit_accept <80, 1, 0 )

#data from not accepted loans (not available, assume credit score is 30% lower)
set.seed(2345); credit_reject <- rnorm(50, mean = 70, sd = 10); hist(credit_reject)
default_reject <- ifelse(credit_reject < 80, 1, 0) #same rejection rate

credit <- c(credit_accept, credit_reject)
c_default <- c(default_accept, default_reject)
d <- cbind(approval, credit, c_default); d <- as.data.frame(d)
colnames(d) <- c("approval", "credit", "c_default")

str(d)

#scale data
#d$credit <- scale(d$credit)

#logit
b_model <- map2stan(
  alist(
    c_default ~ dbinom( 1 , p ) ,
    logit(p) <- b_0 + b_1*credit + (b_2 + b_3*credit) * approval,
    ###prior distributions
    b_0 ~ dnorm( 0 , 2) ,
    b_1 ~ dnorm( b_1_mu, b_1_sig),
    b_1_mu ~ dnorm(0, 1),
    b_1_sig ~ dcauchy(0,1),
    b_2 ~ dnorm(b_2_mu, b_2_sig), 
    b_2_mu ~ dnorm(0,1),
    b_2_sig ~ dcauchy(0,1),
    b_3 ~ dnorm(b_3_mu, b_3_sig),
    b_3_mu ~ dnorm(0,1),
    b_3_sig ~ dcauchy(0,1)),
  data=d , chains=1, cores=4 , iter=1000 ) 

#precis
precis(b_model)

#test with new data, all approved
approval <- c(rep(1, 100))
set.seed(894); credit <- rnorm(100, mean = 100, sd = 10); hist(credit)
c_default <- ifelse(credit < 80, 1, 0 )
newdata <- cbind(approval, credit, c_default); newdata <- as.data.frame(newdata)
colnames(newdata) <- c("approval", "credit", "c_default")

#simulate
sim.m <- sim(b_model, data=newdata, n=500)
mean.prob <- apply(sim.m, 2, mean)

###
pred <- ifelse(mean.prob > .5, 1, 0)
truth <- newdata$c_default
table(pred, truth)


