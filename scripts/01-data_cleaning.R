#### Preamble ####
# Purpose: Clean the full indicator data downloaded from OECD --https://data.oecd.org/gdp/investment-by-sector.htm#indicator-chart
# Author: Youjing Li
# Email: youjing.li@utoronto.ca
# Date: 23 April 2021
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the full indicator investment data from OECD and saved it to inputs/data as raw data.
# Issues: I want to know how the %investment changed over the years in Canada and in neighbouring countries.
# To do: 
# - Load and filter raw files downloaded from OECD directly
# - Save the reduced data


#### Workspace setup ####
library(haven)
library(tidyverse)
library(dplyr)

# Read in the raw data. 
table <- readr::read_csv("inputs/data/raw_data.csv")

#### Column Reduction ####                     
# Keeping variables of interests
names(table) #before column reduction

reduced_data <- 
  table %>% 
  select(LOCATION, 
         SUBJECT,
         TIME,
         Value)
rm(table)

names(reduced_data) #after column reduction

#### Row Reduction ####     
# Keeping timeframe to 4 years before and after 1985
reduced_data <- subset(reduced_data, TIME < "1989")
reduced_data <- subset(reduced_data, TIME > "1979")

#### Save the data ####
write_csv(reduced_data, "inputs/data/cleaned_data.csv")


```{r hh, fig.cap="Bills of penguins", echo = FALSE}

#########################################

# filter treated group to estimate first difference
hh_fdid <- hh %>%
  filter(treat == 1)

ggplot(hh_fdid, aes(x=TIME, y=Value)) +
  geom_line(color = "#F8766D") + theme_classic() +
  geom_vline(xintercept=1985, color = "steelblue", linetype = "dashed") +
  labs(title="% GFCF contributions over years -- household investment", 
       y="% GFCF",x="Years", color = "Region") +
  annotate("text", x = 1983, y = 10, label = "Pre-period", size  =4, color = "steelblue") +
  annotate("text", x = 1987, y = 10, label = "Post-period", size  =4, color = "steelblue")

```

```{r message=FALSE, warning=FALSE, echo=TRUE}
# Calculate first difference for household investment
f_did <- lm(data = hh_fdid, Value ~ post)
stargazer(f_did, type="text")
```

```{r corp, fig.cap="Bills of penguins", echo = FALSE}

#########################################

# filter treated group to estimate first difference
corp_fdid <- corp %>%
  filter(treat == 1)

ggplot(corp_fdid, aes(x=TIME, y=Value)) +
  geom_line(color = "#F8766D") + theme_classic() +
  geom_vline(xintercept=1985, color = "steelblue", linetype = "dashed") +
  labs(title="% GFCF contributions over years -- corporate investment", 
       y="% GFCF",x="Years", color = "Region") +
  annotate("text", x = 1983, y = 10, label = "Pre-period", size  =4, color = "steelblue") +
  annotate("text", x = 1987, y = 10, label = "Post-period", size  =4, color = "steelblue")

```

```{r message=FALSE, warning=FALSE, echo=TRUE}
# Calculate first difference for coporate investment
f_did <- lm(data = corp_fdid, Value ~ post)
stargazer(f_did, type="text")
```

```{r gg, fig.cap="Bills of penguins", echo = FALSE}

#########################################

# filter treated group to estimate first difference
gg_fdid <- gg %>%
  filter(treat == 1)

ggplot(gg_fdid, aes(x=TIME, y=Value)) +
  geom_line(color = "#F8766D") + theme_classic() +
  geom_vline(xintercept=1985, color = "steelblue", linetype = "dashed") +
  labs(title="% GFCF contributions over years -- general government investment", 
       y="% GFCF",x="Years", color = "Region") +
  annotate("text", x = 1983, y = 10, label = "Pre-period", size  =4, color = "steelblue") +
  annotate("text", x = 1987, y = 10, label = "Post-period", size  =4, color = "steelblue")

```
Talk more about it.

```{r message=FALSE, warning=FALSE, echo=TRUE}
# Calculate first difference for general government investment
f_did <- lm(data = gg_fdid, Value ~ post)
stargazer(f_did, type="text")
```
