# Working directory
setwd('C:/Users/kbenn/OneDrive/Documents/grad/phd/dissertation/data/z-a/pixy')

# Load libraries
library(data.table)
library(tidyverse)

# Make ZA function
calc.ZA <- function(dat, zlist) {
  z <- 
    sum(dat[dat$chromosome %in% Zs,]$count_diffs)/
    sum(dat[dat$chromosome %in% Zs,]$count_comparisons)
  a <-
    sum(dat[!dat$chromosome %in% Zs,]$count_diffs)/
    sum(dat[!dat$chromosome %in% Zs,]$count_comparisons)
  
  return(z/a)
}

# Read in population data
el <- fread('EL_pi.txt') %>% drop_na()
em <- fread('EM_pi.txt') %>% drop_na()
eu <- fread('EU_pi.txt') %>% drop_na()
wn <- fread('WN_pi.txt') %>% drop_na()
ws <- fread('WS_pi.txt') %>% drop_na()
wl <- fread('WL_pi.txt') %>% drop_na()
wm <- fread('WM_pi.txt') %>% drop_na()
wu <- fread('WU_pi.txt') %>% drop_na()

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

# Z scaffolds
Zs <- c('NW_021937843.1','NW_021938866.1','NW_021940553.1','NW_021940508.1','NW_021939170.1',
        'NW_021939108.1','NW_021939324.1','NW_021940612.1','NW_021939718.1','NW_021938802.1',
        'NW_021938319.1','NW_021940292.1','NW_021938983.1','NW_021939037.1','NW_021940917.1')

# Calculate Z:A ratios
el_za <- calc.ZA(el, Zs)
em_za <- calc.ZA(em, Zs)
eu_za <- calc.ZA(eu, Zs)
wn_za <- calc.ZA(wn, Zs)
ws_za <- calc.ZA(ws, Zs)
wl_za <- calc.ZA(wl, Zs)
wm_za <- calc.ZA(wm, Zs)
wu_za <- calc.ZA(wu, Zs)

# Update dataframe
pis <- pis %>%
  cbind(za = c(el_za, em_za, eu_za, wn_za, ws_za, wl_za, wm_za, wu_za))

# Plot some stats
plot(pis$n,pis$za)
barplot(pis$za, names.arg = pis$pop)
