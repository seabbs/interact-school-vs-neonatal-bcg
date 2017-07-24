
<!-- README.md is generated from README.Rmd. Please edit that file -->
Interact with a school age vs neonatal BCG vaccination model
============================================================

[This shiny app](http://seabbs.co.uk/shiny/interect-school-vs-neonatal-bcg) allows intetractive exploration of a dynamic infections disease model of school age vs. neonatal BCG vaccination.

Installing the shiny app locally
--------------------------------

To install and run the shiny app locally on your own computer you will need to first install [R](https://www.r-project.org/), it is also suggested that you install [Rstudio](https://www.rstudio.com/products/rstudio/download/). After downloading the source code from [this repository](https://www.github.com/seabbs/interact-school-vs-neonatal-bcg) click on the `s-vs-n-bcg.Rprof` file, this will open an Rstudio window. Type the following code into the command line;

``` r
install.packages("shiny")
install.packages("shinydashboard")
install.packages("shinyBS")
install.packages("tidyverse")
install.packages("rmarkdown")
```

To run the app open the `ui.R` file and press run, depending on your computer this may take some time.
