# Working directory
setwd('C:/Users/kbenn/OneDrive/Documents/grad/phd/dissertation/data/z-a/pixy')

# Load libraries
library(data.table)
library(tidyverse)

# Make ZA function
calc.ZA <- function(dat, autosome) {
  z <- 
    sum(dat[dat$chrom == 'ChrZ',]$count_diffs)/
    sum(dat[dat$chrom == 'ChrZ',]$count_comparisons)
  a <-
    sum(dat[dat$chrom == autosome,]$count_diffs)/
    sum(dat[dat$chrom == autosome,]$count_comparisons)
  
  return(z/a)
}

# Function to make reading data easier
read_pi <- function(path, chrom_df, dropna = TRUE) {
  dat <- fread(path) %>%
    rename(scaffold = chromosome) %>%
    left_join(chrom_df, by = 'scaffold')
  if(dropna == TRUE) {
    dat <- drop_na(dat)
  }
  return(dat)
}

# Read in scaffold-chromosome conversion
chroms <- fread('../chrom-scaf_conversion.txt')


# Read in population data
el <- read_pi('EL_pi.txt', chroms)
em <- read_pi('EM_pi.txt', chroms)
eu <- read_pi('EU_pi.txt', chroms)
wn <- read_pi('WN_pi.txt', chroms)
ws <- read_pi('WS_pi.txt', chroms)
wl <- read_pi('WL_pi.txt', chroms)
wm <- read_pi('WM_pi.txt', chroms)
wu <- read_pi('WU_pi.txt', chroms)

# Calculate total pi
el_pi <- sum(el$count_diffs)/sum(el$count_comparisons)
em_pi <- sum(em$count_diffs)/sum(em$count_comparisons)
eu_pi <- sum(eu$count_diffs)/sum(eu$count_comparisons)
wn_pi <- sum(wn$count_diffs)/sum(wn$count_comparisons)
ws_pi <- sum(ws$count_diffs)/sum(ws$count_comparisons)
wl_pi <- sum(wl$count_diffs)/sum(wl$count_comparisons)
wm_pi <- sum(wm$count_diffs)/sum(wm$count_comparisons)
wu_pi <- sum(wu$count_diffs)/sum(wu$count_comparisons)

# Make pi dataframe
pops <- c('EL', 'EM','EU', 'WN', 'WS', 'WL', 'WM', 'WU')
pi_list <- c(el_pi, em_pi, eu_pi, wn_pi, ws_pi, wl_pi, wm_pi, wu_pi)
pop_n <- c(18, 20, 24, 29, 19, 19, 15, 22)
pis <- data.frame(pop = pops, pi = pi_list, n = pop_n)

# Plot some stats
barplot(pis$pi, names.arg = pis$pop)
plot(pis$n, pis$pi)

# Calculate Z:A ratios
el_za <- calc.ZA(el, 'Chr01A')
em_za <- calc.ZA(em, 'Chr01A')
eu_za <- calc.ZA(eu, 'Chr01A')
wn_za <- calc.ZA(wn, 'Chr01A')
ws_za <- calc.ZA(ws, 'Chr01A')
wl_za <- calc.ZA(wl, 'Chr01A')
wm_za <- calc.ZA(wm, 'Chr01A')
wu_za <- calc.ZA(wu, 'Chr01A')

# Update dataframe
pis <- pis %>%
  cbind(za2 = c(el_za, em_za, eu_za, wn_za, ws_za, wl_za, wm_za, wu_za))

# Plot some stats
plot(pis$n,pis$za2)
barplot(pis$za, names.arg = pis$pop)
