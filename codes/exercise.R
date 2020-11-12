# these two lines generate a matrix of asset prices
set.seed(0)
asset_prices <- matrix(data = rnorm(1000000), nrow = 1000, byrow = T)

prices_info <- function(x){
  
  n <- dim(x)[1]
  
  # create an empty list
  results <- list()
  
  # fill the list with a vector of averages and volatilities (all zeros)
  results$average <- rep(0, n)
  results$volatility <- rep(0, n)
  
  # replace the zeros by computing row averages and volatilities
  for (i in 1:n){
    results$average[i] <- mean(x[i,])
    results$volatility[i] <- sd(x[i,])
  }
  
  results$mu_large <- results$average>=0
  results$sd_large <- results$volatility>=1
  results$both_large <- results$average>=0 & results$volatility>=1
  
  return(results)
}

my_info_big <- prices_info(x = asset_prices)
