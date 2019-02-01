# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")
library("nycflights13")
library("dplyr")

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
nrow(flights)
ncol(flights)
View(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights_new <- flights %>%
  mutate(
    time_gain_lost = dep_delay + arr_delay
  )

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights_new <- flights_new %>%
  arrange(
    -time_gain_lost
  )

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights_new <- flights %>%
  mutate(
    time_gain_lost = dep_delay + arr_delay
  ) %>%
  arrange(
    -time_gain_lost
  )

# Make a histogram of the amount of time gained using the `hist()` function
some <- flights_new %>%
  filter(
    time_gain_lost > 0 
   ) %>%
  hist(some, time_gain_lost)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
number <- flights_new %>%
  filter(
    air_time > 0
  )

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
sea_tac <- flights_new %>%
  filter(
    "SEA" == dest
  ) %>%
  select(
    origin,
    dest,
    time_gain_lost
  )

# On average, did flights to SeaTac gain or loose time?
avg_sea_tac <- sea_tac %>%
  summarise(
    avg_gain_lost = mean(time_gain_lost, na.rm = TRUE)
  )

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
jfk_sea <- flights %>%
  filter(
    origin == "SEA" | origin == "JFK"
  ) %>%
  group_by(
    origin
  ) %>%
  summarise(
    avg_flight = mean(air_time, na.rm = TRUE),
    min_time = min(air_time, na.rm = TRUE),
    max_time = max(air_time, na.rm = TRUE)
  )
