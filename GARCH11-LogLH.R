garch11LL <- function(param, data){
  n <- nrow(data)
  datavec <- rep(0, n)
  datavec <- data[,2]
  #
  resids <- rep(0, n)
  sigma <- matrix(0, n)
  #
  resids[2:n] <- datavec[2:n] - ((param[1]/ 100000)+ ((param[2]/ 100000) * datavec[1:(n-1)]))
  #
  for (i in 2:n){
    sigma[i] <- ((param[3]/ 100000) + ((param[4]/ 100000) * (resids[(i-1)] ^ 2)) + ((param[5]/ 100000) * sigma[(i-1)])) 
  }
  #
  density.matrix <- rep(0, n)
  density.matrix[2:n] <- log(dnorm(resids[2:n], mean = 0, sd = (sigma[2:n] ^ 0.5)))
  #
  LL <- sum(density.matrix)
  return(LL)
}