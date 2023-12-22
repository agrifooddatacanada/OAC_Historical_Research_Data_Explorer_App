# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Amend DESCRIPTION with dependencies read from package code parsing
## install.packages('attachment') # if needed.
attachment::att_amend_desc()
attachment::att_from_rscripts()

## 2.1 Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "metadata", with_test = TRUE) # Name of the module
golem::add_module(name = "data", with_test = TRUE) # Name of the module
golem::add_module(name = "plot", with_test = TRUE) # Name of the module
golem::add_module(name = "example", with_test = TRUE) # Name of the module

## 2.2  Add dependencies

usethis::use_package("DT")
usethis::use_package("bs4Dash")
usethis::use_package("skimr")
usethis::use_package("shinyWidgets")
usethis::use_package("dplyr")
usethis::use_package("ggplot2")


## 2.3  Add helper functions ----
## Creates fct_* and utils_*
golem::add_fct("helpers", with_test = TRUE)
golem::add_fct("readData")  # add readData function
golem::add_utils("helpers", with_test = TRUE)

## 2.4  Add external resources
## Creates .js and .css files at inst/app/www
golem::add_js_file("script")
golem::add_js_handler("handlers")
golem::add_css_file("custom")
golem::add_sass_file("custom")

## 2.5  Add internal datasets ----
## If you have data in your package
usethis::use_data_raw(name = "Fattyacid", open = FALSE)
usethis::use_data_raw(name = "FattyacidMeta", open = FALSE)
usethis::use_data_raw(name = "Feed", open = FALSE)
usethis::use_data_raw(name = "FeedMeta", open = FALSE)
usethis::use_data_raw(name = "Milk", open = FALSE)
usethis::use_data_raw(name = "MilkMeta", open = FALSE)

## 2.6  Tests ----
## Add one line by test you want to create
usethis::use_test("app")

# 3 Documentation

## Vignette ----
usethis::use_vignette("DataExplorer")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
##
## (You'll need GitHub there)
usethis::use_github()

# GitHub Actions
usethis::use_github_action()
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
usethis::use_github_action_check_release()
usethis::use_github_action_check_standard()
usethis::use_github_action_check_full()
# Add action for PR
usethis::use_github_action_pr_commands()

# Travis CI
usethis::use_travis()
usethis::use_travis_badge()

# AppVeyor
usethis::use_appveyor()
usethis::use_appveyor_badge()

# Circle CI
usethis::use_circleci()
usethis::use_circleci_badge()

# Jenkins
usethis::use_jenkins()

# GitLab CI
usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")
