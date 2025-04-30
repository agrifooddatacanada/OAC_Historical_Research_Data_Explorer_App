
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RED-X: Re-usable Data Explorer App


<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of RED-X is to enable users to explore and visualize
historical data from the Borealis database. Users can explore the 
connections between published studies via a network of keywords or authors,
visualize the metadata for the data, check the structure of raw data,
see some basic descriptive statistics and plot the data.

You can check the live version at: https://agrifooddatacanada.shinyapps.io/RED-X

## About the App

RED-X supports the FAIR data principles (Findable, Accessible, Interoperable, and Reusable), helping users:

- Discover reusable datasets from agri-environmental research

- Visualize relationships between datasets, authors, and keywords

- Filter data by college, department, or research center

- Navigate and explore studies in a clean, structured layout

## App Overview

The application consists of four primary tabs:

## 1. Home Tab

Displays intorductory information and summary statistics including:

- Number of Agri-Environment Dataverses

- Total research papers

- Unique authors and keywords

- Metadata and data file counts

## 2. About Tab

Explains the motivation behind the app and its development, emphasizing the importance of reusing historical datasets for research, innovation, and automation in the agri-food sector.

## 3. Network Explorer Tab

Enables users to explore datasets via network plots:

- Filter by College, Campus, Institution, Department, or Research Centre

- View relationships based on Keywords or Authors

## 4. Data Explorer Tab

Allows users to:

- Select a study from a searchable dropdown

- View study overview and objectives

When available, users can:

- Inspect associated metadata

- Explore and visualize data files

## Acknowledgement

The first version of this application was developed during the "Reusable Research Data Made Shiny" workshop hosted at the University of Guelph and supported by Agri-Food Data Canada.

<img src="app/www/workshop1.jpeg" width="100%" />

## License

This project is licensed under the EUPL v1.2 (European Union Public Licence). 
Individual dataset licenses are also displayed in the app when available.

## Contributor Code of Conduct

Please note that the Reusable DataExplorer project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
