#' @title Fattyacid data
#'
#' @description The "Fattyacid" dataset is derived from the borealis database.
#' It provides information on feeding events and milk composition for a study involving
#' different dietary treatments, including fish oil and monensin. The dataset is used
#' to demonstrate the functionality of the DataExplorer App.
#'
#' More information about the data and the study can be found in the borealis database
#' [here](https://borealisdata.ca/dataset.xhtml?persistentId=doi:10.5683/SP3/WVC09T).
#'
#' @format A data with 16 rows and 21 variables
#'
#' \describe{
#'   \item{per}{block}
#'   \item{cow_id}{cow identification number}
#'   \item{trt}{Treatment information}
#'   \item{oil}{Fish oil concentration (0%, 2%)}
#'   \item{mom}{Monensin concentration (mg per kg-1 dietary dry matter)}
#'   \item{C6 - C226}{Concentrations of fatty acids}
#'   \item{fatyld}{ milk fat yields (g d-1)}
#'
#' }
#'
#' @name Fattyacid
#' @keywords Milk composition, Fish oil, Monensin, Omega-3 fatty acids
"Fattyacid"


#' @title Metadata for the Fattyacid data
#'
#' @description The "FattyacidMeta" dataset contains metadata and schema information
#' related to the "Fattyacid" data. It provides details about the structure and context
#' of the Fattyacid dataset.
#'
#' For more comprehensive information about the "Fattyacid" dataset and the study,
#' refer to the borealis database
#' [here](https://borealisdata.ca/dataset.xhtml?persistentId=doi:10.5683/SP3/WVC09T).
#'
#' @name FattyacidMeta
#' @keywords Milk composition, Fish oil, Monensin, Omega-3 fatty acids
"FattyacidMeta"




#' @title Cow Feed Intake Data
#'
#' @description The "Feed" dataset is sourced from the borealis database and serves
#' as an illustrative dataset for showcasing the capabilities of the DataExplorer App.
#'
#' @details This dataset provides insights into cow feed intake, including information
#' on treatment, fish oil concentration, monensin concentration, day of measurement,
#' concentrations of Dry Matter Intake (DMI) for concentrate, silage, and forage,
#' as well as nutritional metrics such as Crude Protein Intake (CPI), Neutral Detergent
#' Fibre Intake (NDFI), Ether Extract Intake (EEI), and Metabolizable Energy Intake (MEI).
#'
#' More information about the dataset and the underlying study can be accessed in the
#' borealis database [here](https://borealisdata.ca/dataset.xhtml?persistentId=doi:10.5683/SP3/WVC09T).
#'
#' @format A data frame with 112 rows and 13 variables
#'
#' \describe{
#'   \item{Cow}{Cow identification number}
#'   \item{per}{block}
#'   \item{trt}{Treatment information}
#'   \item{oil}{Fish oil concentration (2%)}
#'   \item{mon}{Monensin concentration (mg per kg-1 dietary dry matter)}
#'   \item{day}{Day of the measurement}
#'   \item{concDMI}{Concentration of Dry Matter Intake or concentrate Dry Matter Intake}
#'   \item{silDMI}{Silage Dry Matter Intake}
#'   \item{forDMI}{Forage Dry Matter Intake}
#'   \item{CPI}{Crude Protein Intake}
#'   \item{NDFI}{Neutral Detergent Fibre Intake}
#'   \item{EEI}{Ether Extract Intake}
#'   \item{MEI}{Metabolizable Energy Intake (Mcal d-1)}
#'   \item{Units for all}{Units for all variables (kg d-1)}
#'
#' }
#' @name Feed
#' @keywords Milk composition, Fish oil, Monensin, Omega-3 fatty acids
"Feed"



#' @title Metadata for the Feed data
#'
#' @description The "FeedMeta" dataset serves as a metadata companion to the "Feed" dataset.
#' It contains essential metadata and schema information, offering insights into the structure
#' and context of the main "Feed" dataset.
#'
#' For a comprehensive understanding of the "Feed" dataset and the underlying study,
#' refer to the borealis database
#' [here](https://borealisdata.ca/dataset.xhtml?persistentId=doi:10.5683/SP3/WVC09T).
#'
#' @name FeedMeta
#' @keywords Milk composition, Fish oil, Monensin, Omega-3 fatty acids
"FeedMeta"



#' @title Cow Milk Production Data
#'
#' @description The "Milk" dataset, derived from the borealis database, serves as a demonstration
#' of the functionalities of the DataExplorer App.
#'
#' @details This dataset comprises 48 observations, each representing a distinct instance of
#' cow milk production. It includes essential information such as treatment details, fish oil
#' concentration (2%), monensin concentration (mg per kg-1 dietary dry matter), and the nutritional
#' composition of milk, measured in kilograms per day (kg d-1). Additionally, it provides the
#' percentage of fat, protein, and lactose in the milk.
#'
#' For a comprehensive understanding of the dataset and the associated study, refer to the borealis
#' database [here](https://borealisdata.ca/dataset.xhtml?persistentId=doi:10.5683/SP3/WVC09T).
#'
#' @format A data with 48 rows and 10 variables
#'
#' \describe{
#'   \item{Cow}{Cow identification number}
#'   \item{per}{Fake variable description (replace with actual description)}
#'   \item{trt}{Treatment information}
#'   \item{oil}{Fish oil concentration (2%)}
#'   \item{mon}{Monensin concentration (mg per kg-1 dietary dry matter)}
#'   \item{day}{Day of the measurement}
#'   \item{milkkg}{kilogram of milk (kg d-1)}
#'   \item{fatp}{percent fat (%)}
#'   \item{protp}{percent protein (%)}
#'   \item{lactp}{percent lactose (%)}
#'
#' }
#'
#' @name Milk
#' @keywords Milk composition, Fish oil, Monensin, Omega-3 fatty acids
"Milk"


#' @title Metadata for the Milk data
#'
#' @description The "MilkMeta" dataset provides metadata and schema information complementing
#' the main "Milk" dataset. It serves to elucidate the structure and context of the primary dataset.
#'
#' For a comprehensive understanding of the "Milk" dataset and the associated study,
#' refer to the borealis database [here](https://borealisdata.ca/dataset.xhtml?persistentId=doi:10.5683/SP3/WVC09T).
#'
#' @name MilkMeta
#' @keywords Milk composition, Fish oil, Monensin, Omega-3 fatty acids
"MilkMeta"




