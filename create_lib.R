options(repos=c(CRAN="https://cran.uib.no/"))
install.packages("usethis")
install.packages("devtools")
install.packages("reticulate")
library(usethis)
library(devtools)
library(reticulate)


# Create a new package
usethis::create_package("/Users/michato/src/UIO/PROJECTS/tombRaider")

# Navigate to your package directory
setwd("/Users/michato/src/UIO/PROJECTS/tombRaider")

# Create necessary directories and files
usethis::use_description()
usethis::use_namespace()
usethis::use_r("tombRaiderWrapper")
