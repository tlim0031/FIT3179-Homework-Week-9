# get directory
getwd()
setwd("C:/Users/Lim Tong En/Documents/Monash/Sem 2 2024/FIT3179/Week 9/Homework Week 9/w9 homework/FIT3179-Homework-Week-9")

# import libraries
library(dplyr)

# load datasets
world_tourism_ranking = read.csv("world_tourism_ranking.csv")
world_population = read.csv("world_population.csv")

# convert the 'number of international arrivals' column to standardized format
processed_arrivals <- function(arrivals) {
  # Remove whitespace and convert letters to uppercase
  arrivals <- toupper(trimws(arrivals))
  
  # Convert values based on suffix (M: million, K: thousand)
  if (grepl("M$", arrivals)) {
    return(as.numeric(gsub("M$", "", arrivals)) * 1e6)  # million
  }
  else if (grepl("K$", arrivals)) {
    return(as.numeric(gsub("K$", "", arrivals)) * 1e3)  # thousands
  }
  else {
    return(as.numeric(arrivals))  # already in the correct format
  }
}

world_tourism_ranking <- world_tourism_ranking %>%
  mutate(Annual.International.Tourist.Arrivals = sapply(Annual.International.Tourist.Arrivals, processed_arrivals))


# join the datasets and save into new csv file
combined_dataset <- left_join(world_tourism_ranking, world_population, by = "Country")
write.csv(combined_dataset, file = "world_tourism_and_population.csv", row.names = FALSE)

