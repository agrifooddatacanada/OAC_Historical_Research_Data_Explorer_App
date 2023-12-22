#' readData
#'
#' @description An internal function to retrieve data based on the input data name
#' and metadata flag.
#'
#'
#' @param data Character, the name of the data (e.g., "Fattyacid", "Milk", "Feed").
#' @param is_metadata Logical, indicates whether metadata should be retrieved.
#'
#' @return The requested data or metadata object from the DataExplorer package.
#'
#' @noRd

get_data <- function(data, is_metadata = FALSE) {

  # Check if the input data is "Fattyacid"
  if (data %in% "Fattyacid") {
    # Check if metadata is requested
    if (is_metadata) {
      # Return the metadata object from the DataExplorer package
      return(DataExplorer::FattyacidMeta)
    } else {
      # Return the data object from the DataExplorer package
      return(DataExplorer::Fattyacid)
    }
  }

  # Check if the input data is "Milk"
  if (data %in% "Milk") {
    # Check if metadata is requested
    if (is_metadata) {
      # Return the metadata object from the DataExplorer package
      return(DataExplorer::MilkMeta)
    } else {
      # Return the data object from the DataExplorer package
      return(DataExplorer::Milk)
    }
  }

  # Check if the input data is "Feed"
  if (data %in% "Feed") {
    # Check if metadata is requested
    if (is_metadata) {
      # Return the metadata object from the DataExplorer package
      return(DataExplorer::FeedMeta)
    } else {
      # Return the data object from the DataExplorer package
      return(DataExplorer::Feed)
    }
  }
}




