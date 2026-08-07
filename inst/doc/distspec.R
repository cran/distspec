## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
set.seed(1)

## ----setup--------------------------------------------------------------------
library(distspec)
library(ggplot2)

## ----quickstart---------------------------------------------------------------
delays <- Gamma(mean = 4, sd = 2, max = 20) +
  LogNormal(meanlog = 1, sdlog = 0.5, max = 20)
get_pmf(collapse(discretise(delays)))

## ----quickstart-plot, fig.width = 7, fig.height = 4, fig.alt = "PMF and CDF of a gamma and a lognormal delay."----
plot(delays)

## ----define-------------------------------------------------------------------
Gamma(shape = 2, rate = 0.5)
Gamma(mean = 4, sd = 2)
LogNormal(meanlog = 1, sdlog = 0.5)

## ----bound--------------------------------------------------------------------
Gamma(mean = 4, sd = 2, max = 20)

## ----uncertain----------------------------------------------------------------
uncertain <- Gamma(shape = Normal(2, 0.5), rate = Normal(0.5, 0.1))
uncertain

# the mean of an uncertain distribution is unknown unless we ignore uncertainty
mean(uncertain)
mean(uncertain, ignore_uncertainty = TRUE)

## ----fix----------------------------------------------------------------------
fix_parameters(uncertain, strategy = "mean")

## ----discretise---------------------------------------------------------------
pmf <- discretise(Gamma(mean = 4, sd = 2, max = 20))
get_pmf(pmf)

## ----combine------------------------------------------------------------------
combined <- Gamma(mean = 4, sd = 2, max = 20) +
  LogNormal(meanlog = 1, sdlog = 0.5, max = 20)
get_pmf(collapse(discretise(combined)))

## ----combine-mean-------------------------------------------------------------
mean(collapse(discretise(combined)))

## ----plot, fig.width = 7, fig.height = 4, fig.alt = "PMF and CDF of a discretised gamma distribution."----
plot(discretise(Gamma(mean = 4, sd = 2, max = 20)))

## ----plot-uncertain, fig.width = 7, fig.height = 4, fig.alt = "Sampled PMFs of an uncertain gamma distribution."----
plot(
  Gamma(shape = Normal(3, 0.5), rate = Normal(2, 0.5), max = 20),
  cumulative = FALSE
)

## ----sample-------------------------------------------------------------------
sample_dist(Gamma(mean = 4, sd = 2, max = 20), n = 5)

## ----uncertain-nonparametric--------------------------------------------------
est <- NonParametric(pmf = Dirichlet(c(0, 2, 4, 3)))
est

## ----has-uncertainty----------------------------------------------------------
has_uncertainty(est)
has_uncertainty(Gamma(shape = 2, rate = 0.5))

