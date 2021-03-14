library(dplyr)
library(ggplot2)

# Load data
df <- readr::read_csv("scone_demand_data.txt")

# Explore data
df %>% 
  ggplot(aes(x = Demand)) +
  geom_histogram(binwidth = 1)

summary(df[1])
dim(df)

# Modify data
df <- df %>% 
  mutate(Demand = ifelse(Demand == 1800, 18, Demand)) 
  #arrange(desc(Demand))

# Set constants
price <- 2.49
salvage <- 0.99
cost <- 1.24
stocking <- c(3:18)

# Profit Function & Matrix
profit <- matrix(0, nrow = nrow(df), ncol = length(stocking))

for (i in 1:length(stocking)) { # loop for each stocking level
  q <- stocking[i]
  for (j in 1:nrow(df)) { # loop for each realized demand
    profit[j,i] <- price * min(q, df[[j,1]]) + salvage * max(q - df[[j,1]], 0) - cost * q
  }
}

# make summary table
summary_table <- data.frame(
  stocking = stocking,
  AvgProf = apply(profit, 2, mean), # column means
  StdProf = apply(profit, 2, sd) # column sd
)


# Visualize

summary_table %>% 
  ggplot(aes(x = stocking, y = AvgProf)) +
  geom_line() +
  xlab("stocking amount") +
  ylab("Ave. Profit")

summary_table %>% 
  ggplot(aes(x = stocking, y = StdProf)) +
  geom_line() +
  xlab("stocking amount") +
  ylab("Sd. Profit")

#-------------------------#
# Optimal stocking
#-------------------------#
optimal_profit <- max(summary_table$AvgProf)
optimal_stocking <- summary_table$stocking[which.max(summary_table$AvgProf)]
print(optimal_stocking) 

#-------------------------#
# Safety stock
#-------------------------#
safety_stock <- optimal_stocking - mean(df$Demand)
print(safety_stock)

#-------------------------#
# Value of oracle
#-------------------------#
value_of_oracle <- (price - cost) * mean(df$Demand) - optimal_profit
print(value_of_oracle)

