# By Lida Xu
rm(list = ls()) # reset the workspace

normalize<-function(X){
  Xnorm <- scale(X,center = T,scale = T)
  return(Xnorm)
}

sigmoid <- function(z){
  mn <- dim(z)
  one_matrix = matrix( rep( 1, len=mn[1]*mn[2]), nrow = mn[1])
  g = one_matrix/(1+exp(-z))
  return(g)
}

computeCost <- function(theta, X, y, lambda){
  m = length(y)
  cost =0
  mn1 = length(theta)
  
  if (nargs()<4)
  {
    lambda=0
  }
  
  z = X%*%theta
  h = sigmoid(z)
  
  grad = ((1/m) * (t(h-y) %*% X)) + lambda*(t(c(0,theta[2:mn1[1]])))/m
  
  cost = (1/m )* sum(-y*log(h)-(1-y)*log(1-h)) + (lambda/m)/2 * sum(theta[2:length(theta)]^2)
  
  output = list(cost=cost,grad=grad)
  return(output)
}


selectk <-function(v,k){
  N   <- k
  vec <- v
  lst <- lapply(numeric(N), function(x) vec)
  y<-as.matrix(expand.grid(lst)) 
  y<- y[,ncol(y):1]
}

mapping <- function(X,degree){
  mn = dim(X)
  power = selectk(c(0:degree),mn[2])
  ind = rowSums(power) <=degree
  power = power[ind,]
  p = dim(power)
  Xmap = rep(1,times = mn[1])
  for(i in 1:p[1])
  {
    aterm = rep(1,times=mn[1])
    for(j in 1:mn[2])
    {
      aterm = aterm * (X[,j]^power[i,j])
    }
    Xmap = cbind(Xmap,aterm)
  }
  return(Xmap)
}


############### main partt############
data <-  read.csv("bankruptcy.csv",header = T, sep = ",")
smp_size <- floor(0.6 * nrow(data))
train_ind <- sample(seq_len(nrow(data)), size = smp_size)

X <- data[,2:13]
X <- normalize(X)
mn <- dim(X)
X<- cbind(rep(1,times=dim(X)[1]),X)
y <- data[,14]

xtrain = X[train_ind,]
ytrain = y[train_ind]
xtest = X[-train_ind,]
ytest = y[-train_ind]


theta <- as.numeric(rep(0,times=mn[2]+1))

################# without regulariztion ###########
g <- function(t) computeCost(t, xtrain, ytrain)$cost
grad <- function(t) computeCost(t, xtrain, ytrain)$grad


output<- optim(par = theta, fn = g, gr = grad, method = "BFGS")
theta <- output$par
cost<- output$value

pred = sigmoid(xtest%*%theta) >= 0.5

print(paste0("Accuracy: ",mean(pred==ytest)*100, "%"))

#################### regularization ######################
# Reload data
data <-  read.csv("bankruptcy.csv",header = T, sep = ",")
X <- data[,2:13]
X <- normalize(X)
y <- data[,14]



################ mapping to higher dimensional space ##########
X = mapping(X,2);

smp_size <- floor(0.6 * nrow(data))
train_ind <- sample(seq_len(nrow(data)), size = smp_size)
xtrain = X[train_ind,]
ytrain = y[train_ind]
xtest = X[-train_ind,]
ytest = y[-train_ind]


theta = rep(0,dim(X)[2])
lambda = 0.01

################ optimization ####################
g <- function(t) computeCost(t, xtrain, ytrain,lambda)$cost
grad <- function(t) computeCost(t, xtrain, ytrain,lambda)$grad


output<- optim(par = theta, fn = g, gr = grad, method = "BFGS")
theta <- output$par
cost<- output$value

pred = sigmoid(xtest%*%theta) >= 0.5

print(paste0("Accuracy: ",mean(pred==ytest)*100,"%"))





