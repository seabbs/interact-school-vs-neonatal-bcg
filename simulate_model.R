## Install model
#devtools::install_github("seabbs/ModelTransVsDirectBCG")

## Install utility modelling package
#devtools::install_github("seabbs/idmodelr")

## Load the modelling package
library(ModelTransVsDirectBCG)

## Load other packages
library(tidyverse)
library(idmodelr)

## Load data from package
## Set a global timestep - daily
global_timestep <- 1/365

## Extract only non-UK born cases that had pulmonary TB
non_uk_born_inc <- convert_incidence_for_model(df = incidence, 
                                               inc_label = "iota",
                                               pulm_tb = TRUE, 
                                               extrapulm_tb = FALSE, 
                                               include_na_pulm_tb = FALSE,
                                               uk_born = FALSE, 
                                               non_uk_born = TRUE, 
                                               include_na_uk_born = FALSE,
                                               keep_na_age = FALSE, 
                                               type = "all")

## Smooth non-uk born incidence - assuming constant incidence based on 2016 smoothed estimates
smooth_non_uk_born_inc <- non_uk_born_inc %>% 
  smooth_incidence(time = "year", timestep = global_timestep,
                   burn_in_assumption = "constant",
                   burn_in = 0,
                   project_forward_assumption = "constant",
                   project_forward = 100 - nrow(.),
                   inc_label = "iota", 
                   age_groups = 3)

## Set up model - using dummy incidence data
model <- data_frame(year = 0:100, incidence1 = NA, incidence2 = NA, incidence3 = NA) %>%
  dis_vac_age_model(time = "year",
                    t0 = 0, 
                    timestep = global_timestep, 
                    covars = select(smooth_non_uk_born_inc, -year),
                    tcovar = "time",
                    nstageA = 3)


## Scenarios to test
scenarios <- data_frame(scenario = c("school_age", "neonatal", "no_vac") %>% factor, 
                        gamma_log1 = c(0, 1, 0),
                        gamma_log2 = c(1, 0, 0),
                        gamma_log3 = c(0, 0, 0),
                        alpha_log1 = c(0, 1, 0),
                        alpha_log2 = c(1, 0, 0),
                        alpha_log3 = c(0, 0, 0),
                        id = 1)

## Parameters
fixed_params <- c(N_init = 50606034, init_I = 0, init_E_1 = 0, init_E_2 = 0, mu = 1/81, 
                  theta = c(1/15, 1/15, 0), age_weight = c(0.3, 0.3, 0.4), C = rep(1, 9))

## sample params - required to generate parameters from distribution not used in permutation analysis
sample_params <- c(epsilon_1 = 2, kappa = 1/2, epsilon_2 = 1/80, nu = 1/2,
                   gamma = c(0, 0.75, 0), sigmaSE = 0, 
                   alpha = c(0, 0.75, 0), rho = 1, k = 0)
