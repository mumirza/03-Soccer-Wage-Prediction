# Muhammad Umer Mirza, 17/12/2023, ALY 6010
# Final Project - Milestone 3 

# Clear the Console
cat("\014")  # Clears the console
rm(list = ls())  # Clears the global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE)  # Clears plots
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE)  # Clears packages
options(scipen = 100)  # Disables scientific notation for the entire R session

# Load Necessary Packages
library(pacman)
library(tidyverse)
library(janitor)
library(lubridate)
library(ggthemes)
library(ggeasy)
library(psych)
library(knitr)
library(kableExtra)
library(janitor)

# Load Data
soccer_wages <- read.csv("SalaryPrediction.csv")

# Inspect Data
dim(soccer_wages) # check number of rows and columns
colnames(soccer_wages) # check column names
head(soccer_wages) # check top 10 observations of the data 
str(soccer_wages) # check the structure of each column
sapply(soccer_wages, function(x) length(unique(x))) # check no. of unique values in each column

# Clean Data 
soccer_wages <- clean_names(soccer_wages) # make column names R friendly 
# Rename columns for better understanding
soccer_wages <- soccer_wages %>%
  rename(club_apps = apps, international_apps = caps)

# Remove commas from wage column
soccer_wages$wage <- gsub(",", "", soccer_wages$wage)
# Correct data structure for wage column 
soccer_wages$wage <- as.numeric(soccer_wages$wage)

# Check for unique values names in league column
unique_leagues <- unique(soccer_wages$league)
unique_leagues
# Correct data structure for league column and set levels for the factor
soccer_wages$league <- factor(soccer_wages$league, levels = c("Premier League", "La Liga", "Bundesliga", "Serie A", "Ligue 1 Uber Eats", "Primiera Liga"))

# Check for unique values names in position column
unique_positions <- unique(soccer_wages$position)
unique_positions
# Correct data structure for position column and set levels for the factor
soccer_wages$position <- factor(soccer_wages$position, levels = c("Goalkeeper", "Defender", "Midfilder", "Forward"))

# Ensure structure changes are completed 
str(soccer_wages) 
# Check for n/a values
sapply(soccer_wages, function(x) sum(is.na(x))) 

# Remove egregiously and not believable wages based on previous analysis and comments by instructor   
# Remove rows where wage is greater than equal to $10 million
soccer_wages <- soccer_wages[soccer_wages$wage <= 10000000,]
# Check dimensions of clean data
dim(soccer_wages)

# Descriptive stats for continuous variables
# Calculate descriptive statistics
calculate_stats <- function(data_column) {
  quants <- quantile(data_column, probs = c(0.25, 0.75))
  names(quants) <- c("25TH PERCENTILE", "75TH PERCENTILE")
  stats <- data.frame(
    MIN = min(data_column),
    MAX = max(data_column),
    MEAN = round(mean(data_column), 2),
    SD = round(sd(data_column), 2),
    MEDIAN = median(data_column))
  c(stats, quants)}

# Apply the function to each variable
wage_stats <- calculate_stats(soccer_wages$wage)
age_stats <- calculate_stats(soccer_wages$age)
club_apps_stats <- calculate_stats(soccer_wages$club_apps)
international_apps_stats <- calculate_stats(soccer_wages$international_apps)

# Create a data frame for the combined statistics
combined_stats_df <- data.frame(
  Variable = c("Wage ($)", "Age", "Club Apps", "International Apps"),
  rbind(wage_stats, age_stats, club_apps_stats, international_apps_stats))
# Ensure the column names are set correctly without the 'X'
names(combined_stats_df)[names(combined_stats_df) == "X25TH.PERCENTILE"] <- "25TH PERCENTILE"
names(combined_stats_df)[names(combined_stats_df) == "X75TH.PERCENTILE"] <- "75TH PERCENTILE"

# Use kable to create the table with combined_stats_df
table_1 <- kable(combined_stats_df, 
                 caption = "Table 1: Descriptive Statistics of Continuous Data", 
                 row.names = FALSE) %>%
  kable_classic(full_width = F, html_font = "Cambria")%>%
  footnote(general = "Wages are annual figures in US dollars.")


# Print the table
print(table_1)

# Distribution of continuous variables
# Set up the plotting area for a 4x4 grid (adjust mfrow as needed)
par(mfrow = c(2, 2))

# Histograms
hist(soccer_wages$wage, main = "Histogram of Wages", xlab = "Wages")
hist(soccer_wages$age, main = "Histogram of Age", xlab = "Age")
hist(soccer_wages$club_apps, main = "Histogram of Club Apps", xlab = "Club Apps")
hist(soccer_wages$international_apps, main = "Histogram of International Apps", xlab = "International Apps")

# Boxplots
boxplot(soccer_wages$wage, main = "Boxplot of Wages", ylab = "Wages")
boxplot(soccer_wages$age, main = "Boxplot of Age", ylab = "Age")
boxplot(soccer_wages$club_apps, main = "Boxplot of Club Apps", ylab = "Club Apps")
boxplot(soccer_wages$international_apps, main = "Boxplot of International Apps", ylab = "International Apps")

# Reset to default single plotting layout
par(mfrow = c(1, 1))

# Create descriptive statistics of factor variables 
# Group data by League
# For league
league_table <- soccer_wages %>%
  group_by(league) %>%
  summarise(count = n()) %>%
  mutate(percentage = round(count / sum(count) * 100, 2))

# Create a n and % table for the league variable in descending order
table_2 <- league_table %>%
  arrange(desc(percentage)) %>%
  kable(caption = "Table 2: Descriptive Statistics of Leagues", format = "html", row.names = FALSE) %>%
  kable_classic(full_width = F, html_font = "Cambria") %>%
  row_spec(0, bold = TRUE)
print(table_2)

# For position
position_table <- soccer_wages %>%
  group_by(position) %>%
  summarise(count = n()) %>%
  mutate(percentage = round(count / sum(count) * 100, 2))

# Create a n and % table for the position variable in descending order
table_3 <- position_table %>%
  arrange(desc(percentage)) %>%
  kable(caption = "Table 3: Descriptive Statistics of Player Position", format = "html", row.names = FALSE) %>%
  kable_classic(full_width = F, html_font = "Cambria") %>%
  row_spec(0, bold = TRUE)
print(table_3)

# Data Analysis

# Two sample t-tests
# Per my EDA defenders and midfielders represent the most number of wages reported in the dataset
# I want to explore if there is a difference in average wage for these two playing positions
# Do independent two-tailed t-test
# At a 0.05 alpha, is there a statistically significant difference in average wages between defenders and midfielders?

# H0: μ_defenders = μ_midfielders
# H1: μ_defenders ≠ μ_midfielders 

# Subset data
defenders <- subset(soccer_wages, position == "Defender")
midfielders <- subset(soccer_wages, position == "Midfilder")

# Calculate descriptive statistics for defenders and midfielders
defender_stats <- calculate_stats(defenders$wage)
midfielders_stats <- calculate_stats(midfielders$wage)

# Combine the stats into a data frame
d_m_stats_df <- rbind(Defender = defender_stats, Midfilder = midfielders_stats)
print(d_m_stats_df)
d_m_stats_df %>%
  kbl(caption="Table 4: Descriptive Statistics of Wage for Defender's and Midfielder's")%>%
  kable_classic(full_width = F, html_font = "Cambria")%>%
  row_spec(0, bold = TRUE)

# Create box plots
# Set up the plotting area for boxplots
par(mfrow = c(1, 2))

# Boxplot for defender
boxplot(defenders$wage, 
        main = "Defender Wages", 
        ylab = "Wages ($)", 
        col = "lightblue")

# Boxplot for midfielder
boxplot(midfielders$wage, 
        main = "Midfielder Wages", 
        ylab = "Wages ($)", 
        col = "lightgreen")

# Reset plot area to default
par(mfrow = c(1, 1))

# Create histograms
# Set up the plotting area for histograms
par(mfrow = c(2, 1))

# Histogram for defender
hist(defenders$wage, 
     main = "Histogram of Defender Wages", 
     xlab = "Wages ($)", 
     col = "lightblue", 
     border = "darkblue", 
     breaks = 50)

# Histogram for midfielders 
hist(midfielders$wage, 
     main = "Histogram of Midfielder Wages", 
     xlab = "Wages ($)", 
     col = "lightgreen", 
     border = "darkgreen", 
     breaks = 50)

# Reset plot area to default
par(mfrow = c(1, 1))

# Perform f-test to check variance 
d_m_f_test_result <- var.test(defenders$wage, midfielders$wage)
d_m_f_test_result

# H0: μ_defenders = μ_midfielders
# H1: μ_defenders ≠ μ_midfielders
# Two-tail t-test
# Variances not equal
d_m_t_test_result <- t.test(defenders$wage, midfielders$wage, 
                            alternative = "two.sided", 
                            var.equal = FALSE) 
d_m_t_test_result

# Per my EDA premier league and primiera liga represent the most number of wages reported in the dataset
# I want to explore if there is a difference in average wage for these two leagues
# Do independent two-tailed t-test
# At a 0.05 alpha, is there a statistically significant difference in average wages between premier league and primiera liga?

# Create subsets
premier_league <- subset(soccer_wages, league == "Premier League")
primiera_liga <- subset(soccer_wages, league == "Primiera Liga")

# Calculate descriptive statistics for premier league and primiera liga
premier_league_stats <- calculate_stats(premier_league$wage)
primiera_liga_stats <- calculate_stats(primiera_liga$wage)

# Combine the stats into a data frame
p_l_stats_df <- rbind("Premier League" = premier_league_stats, "Primiera Liga" = primiera_liga_stats)
print(p_l_stats_df)
p_l_stats_df %>%
  kbl(caption="Table 5: Descriptive Statistics of Wage for Premier League and Primiera Liga")%>%
  kable_classic(full_width = F, html_font = "Cambria")%>%
  row_spec(0, bold = TRUE)

# Create box plots
# Set up the plotting area for boxplots
par(mfrow = c(1, 2))

# Boxplot for premier league
boxplot(premier_league$wage, 
        main = "Premier League Wages", 
        ylab = "Wages ($)", 
        col = "lightblue")

# Boxplot for primiera liga
boxplot(primiera_liga$wage, 
        main = "Primiera Liga Wages", 
        ylab = "Wages ($)", 
        col = "lightgreen")

# Reset plot area to default
par(mfrow = c(1, 1))

# Create histograms
# Set up the plotting area for histograms
par(mfrow = c(2, 1))

# Histogram for Premier League
hist(premier_league$wage, 
     main = "Histogram of Premier League Wages", 
     xlab = "Wages ($)", 
     col = "lightblue", 
     border = "darkblue", 
     breaks = 50)

# Histogram for Primiera Liga 
hist(primiera_liga$wage, 
     main = "Histogram of Primiera Liga Wages", 
     xlab = "Wages ($)", 
     col = "lightgreen", 
     border = "darkgreen", 
     breaks = 50)

# Reset plot area to default
par(mfrow = c(1, 1))

# Perform f-test to check variance 
p_l_f_test_result <- var.test(premier_league$wage, primiera_liga$wage)
p_l_f_test_result

# H0: μ_premier_league = μ_primiera_liga
# H1: μ_premier_league ≠ μ_primiera_liga
# Two tail t-test
# Variances not equal
p_l_t_test_result <- t.test(premier_league$wage, primiera_liga$wage, 
                            alternative = "two.sided", 
                            var.equal = FALSE) 
p_l_t_test_result

# Regression
# I want to see how wage changes based on age club and international appearances
# Do a regression test
# Dependent variable y = wage
# Independent variable x = age + club_apps + international_apps
# Explore relationship of wage with each independent variable 

# install.packages("corrplot")
# install.packages("gclus")

# Load required libraries
library(corrplot)
library(gclus)

# Calculate the correlation matrix for numeric variables
correlation_matrix <- cor(soccer_wages[, sapply(soccer_wages, is.numeric)], use = "complete.obs")
correlation_matrix <- round(correlation_matrix, 3)

# Visualize the correlation matrix with numbers
corrplot(correlation_matrix, method = "number")

# Visualize the correlation matrix with colors and correlation numbers
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(correlation_matrix, method = "color", col = col(200),  
         type = "upper", order = "hclust", 
         addCoef.col = "black", tl.col = "black", tl.srt = 15, 
         number.cex = 0.8, diag = FALSE)
title("Correlation Matrix for Soccer Wages", line = 2)

# Visualize the correlation matrix using cpairs from the gclus package
dta.r <- abs(correlation_matrix) # Get absolute values of correlations
dta.col <- dmat.color(dta.r) # Get colors based on the correlation
dta.o <- order.single(dta.r) # Order variables based on the correlation

# Adjust the column selection to the numeric columns in soccer_wages
cpairs(soccer_wages[, sapply(soccer_wages, is.numeric)], dta.o, panel.colors = dta.col, gap = .5,
       main = "Scatterplot Matrix for Soccer Wages")

# Create a simple scatterplot matrix using base R
# Adjust the formula to include the numeric variables from your dataset
pairs(~age + wage + club_apps + international_apps, data = soccer_wages,
      main = "Simple Scatterplot Matrix for Soccer Wages")

# Conduct regression analysis 
model <- lm(wage ~ age + club_apps + international_apps, data = soccer_wages)
# Summary of the regression model to view coefficients and statistics
summary(model)
plot(model)
confint(model)

# Scatterplot and regression line for age
ggplot(soccer_wages, aes(x = age, y = wage)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Regression of Wage on Age", x = "Age", y = "Wage") +
  theme_minimal()

# Scatterplot and regression line for club_apps
ggplot(soccer_wages, aes(x = club_apps, y = wage)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Regression of Wage on Club Apps", x = "Club Apps", y = "Wage") +
  theme_minimal()

# Scatterplot and regression line for international_apps
ggplot(soccer_wages, aes(x = international_apps, y = wage)) +
  geom_point() +  # Plot the individual data points
  geom_smooth(method = "lm", se = FALSE) +  # Add the regression line without the standard error band
  labs(title = "Regression of Wage on International Apps",
       x = "International Apps",
       y = "Wage") +
  theme_minimal()

# End of Analysis
