# global.R

# Load required libraries

## 1. Base R : These are libraries primarily focused on foundational data manipulation, I/O, and processing
library(data.table)
library(stringr)
library(purrr)
library(readxl)
library(jsonlite)
library(dplyr)
library(tidyr)
library(dbplyr)
library(reactable)

## 2. User Experience (UX): These libraries enhance the interface and interactivity

library(shiny)
library(shinyalert)
library(shinycssloaders)
library(shinyjs)
library(shinyWidgets)
library(bs4Dash)
library(reactlog)
library(glue)
library(RColorBrewer)
library(waiter)

## 3. Visualization: These libraries are used for creating visual representations of data

library(visNetwork)
library(heatmaply)
library(DT)
library(DataExplorer)


## 4. API/HTTP/database: These libraries are specifically for working with APIs, HTTP requests and connecting to database:

library(httr2)
library(DBI)
library(RSQLite)


# Initialize an empty list to store modules, tabs and functions
explorer_list <- list()

# List all R script files from the "App_modules" and "App_function" directories
my_helpers <- list.files(
  c("appFunction", "appTabs"), # Directories to search in
  recursive = TRUE,   # Search within sub-directories
  full.names = TRUE,  # Return full file paths instead of just file names
  pattern = "\\.R$"   # Match only files ending with ".R"
)

# Loop through the list of R script files and source them (execute their contents)
for (f in my_helpers) {
  source(f)  # Load the script into the current R session, allowing functions and variables to be used
}

