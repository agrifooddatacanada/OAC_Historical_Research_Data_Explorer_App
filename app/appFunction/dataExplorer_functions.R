Api_token <- Sys.getenv("API_TOKEN")  # Retrieve the API token from environment variables

# Function to extract datasets information from the Agri-environment dataverse
# using the recursive function.
fetch_all_datasets <- function(id, layer_titles = character()) {
  base_url <- "https://borealisdata.ca/api/dataverses/"
  results <- tibble()
  
  # Exclude specific dataverse ID
  if (id == "147125") return(results)
  
  url <- paste0(base_url, id, "/contents")
  response <- tryCatch({
    request(url) %>%
      req_headers(`X-Dataverse-key` = Api_token) %>%
      req_perform()
  }, error = function(e) {
    message("Request failed for Dataverse ", id, ": ", e$message)
    return(NULL)
  })
  
  if (!is.null(response) && response$status == 200) {
    dataverse_raw_data <- fromJSON(rawToChar(response$body), flatten = TRUE) %>%
      as_tibble()
    
    title <- tryCatch({
      meta_url <- paste0(base_url, id)
      meta_response <- request(meta_url) %>%
        req_headers(`X-Dataverse-key` = Api_token) %>%
        req_perform()
      meta_data <- fromJSON(rawToChar(meta_response$body), flatten = TRUE)
      meta_data$data$name
    }, error = function(e) {
      message("Failed to retrieve title for Dataverse ", id, ": ", e$message)
      return(NA_character_)
    })
    
    current_layer_titles <- c(layer_titles, title)
    
    # Initialize columns to ensure they exist
    if (nrow(results) == 0) {
      results <- tibble(
        Agri_Environment = character(0),
        College_Campus_Institution = character(0),
        Departments_ResearchCentres = character(0),
        id = character(0),
        protocol = character(0),
        authority = character(0),
        identifier = character(0),
        persistent_id = character(0)
      )
    }
    
    if (!is.null(dataverse_raw_data$data) && length(dataverse_raw_data$data) > 0) {
      datasets <- dataverse_raw_data$data %>% filter(type == "dataset")
      
      # Simplify the layer assignment logic
      datasets <- datasets %>%
        mutate(
          Agri_Environment = current_layer_titles[1],
          College_Campus_Institution = ifelse(length(current_layer_titles) > 1, current_layer_titles[2], current_layer_titles[1]),
          Departments_ResearchCentres = ifelse(length(current_layer_titles) > 2, current_layer_titles[3], NA_character_)
        ) %>%
        mutate(id = as.character(id))  # Ensure id is character
      
      # Add datasets to results
      results <- bind_rows(results, datasets)
      
      # Recurse into sub-dataverses
      dataverses <- dataverse_raw_data$data %>% filter(type == "dataverse")
      if (nrow(dataverses) > 0) {
        for (dv_id in dataverses$id) {
          results <- bind_rows(results, fetch_all_datasets(dv_id, current_layer_titles))
        }
      }
      
      # Handle persistent_id and filter invalid rows
      results <- results %>%
        mutate(
          persistent_id = ifelse(
            !is.na(protocol) & !is.na(authority) & !is.na(identifier),
            paste0(protocol, ":", authority, "/", identifier),
            NA_character_
          )
        ) %>%
        filter(!is.na(persistent_id))
    } else {
      message("No data available for ID ", id)
    }
  } else {
    message("Failed to fetch data for Dataverse ", id, ": HTTP status ", response$status)
  }
  
  # Reassign specific datasets to new dataverses and clean up columns
  results <- results %>%
    mutate(
      College_Campus_Institution = case_when(
        id == 103712 ~ "Ontario Agricultural College",
        id == 200306 ~ "Agri-food Data Canada",
        TRUE ~ College_Campus_Institution
      ),
      Departments_ResearchCentres = case_when(
        id == 103712 ~ "Department of Plant Agriculture",
        TRUE ~ Departments_ResearchCentres
      )
    ) %>%
    select(-Agri_Environment) %>%   # Remove first layer
    arrange(College_Campus_Institution, Departments_ResearchCentres)  # Sorting by columns
  
  return(results)
}


# Function to fetch metadata of each dataverse in OAC repo based on their DOIs
## DOIs are gotten from the fetch_dataverse_data()

fetch_study_details <- function(data) {
  if (!is.data.frame(data) || !"persistent_id" %in% names(data) || nrow(data) == 0) {
    warning("Invalid input: Ensure 'data' is a dataframe and contains 'persistent_id' column.")
    return(tibble())  # Return an empty tibble if input is invalid
  }
  
  BaseURL_details2 <- "https://borealisdata.ca/api/datasets/export?exporter=schema.org&persistentId="
  
  detailed_data_list <- vector("list", nrow(data))  # Preallocate for efficiency
  
  for (i in seq_len(nrow(data))) {
    persistent_id <- data$persistent_id[i]  # Extract persistent_id from dataframe
    Full_url_details <- paste0(BaseURL_details2, persistent_id)
    
    tryCatch({
      response_details <- request(Full_url_details) %>%
        req_headers(`X-Dataverse-key` = Api_token) %>%
        req_perform()
      
      if (response_details$status == 200) {
        detail_oac2 <- jsonlite::fromJSON(rawToChar(response_details$body), flatten = TRUE)
        
        # Extract and handle missing data safely
        detailed_data_list[[i]] <- tibble(
          Title = detail_oac2[["name"]],
          PublicationDate = detail_oac2[["datePublished"]],
          Authors = if (!is.null(detail_oac2[["author"]])) paste(detail_oac2[["author"]][["name"]], collapse = "; ") else NA,
          Affiliations = if (!is.null(detail_oac2[["author"]][["affiliation.name"]])) paste(detail_oac2[["author"]][["affiliation.name"]], collapse = "; ") else NA,
          Keywords = if (!is.null(detail_oac2[["keywords"]])) paste(detail_oac2[["keywords"]], collapse = "; ") else NA,
          Objectives = detail_oac2[["description"]],
          Citation = if (!is.null(detail_oac2[["citation"]])) paste(detail_oac2[["citation"]][["name"]], collapse = ", ") else NA,
          PeriodCovered = if (!is.null(detail_oac2[["temporalCoverage"]])) paste(detail_oac2[["temporalCoverage"]], collapse = "; ") else NA,
          StudyLocation = if (!is.null(detail_oac2[["spatialCoverage"]])) paste(detail_oac2[["spatialCoverage"]], collapse = ", ") else NA,
          Funder = if (!is.null(detail_oac2[["funder"]])) paste(detail_oac2[["funder"]][["name"]], collapse = "; ") else NA,
          FileList = if (!is.null(detail_oac2[["distribution"]])) paste(detail_oac2[["distribution"]][["name"]], collapse = "; ") else NA,
          DataLicense = if (!is.null(detail_oac2[["license"]])) paste(detail_oac2[["license"]], collapse = "; ") else NA,
          DOI = persistent_id,  # Ensure DOI is linked correctly
          CollegeName = data$College_Campus_Institution[i],
          DepartmentName = data$Departments_ResearchCentres[i]
        )
      } else {
        warning(paste("Failed to fetch data for DOI:", persistent_id, "Status code:", response_details$status))
      }
    }, error = function(e) {
      message("Error fetching details for DOI ", persistent_id, ": ", e$message)
      detailed_data_list[[i]] <- tibble()  # Store an empty tibble on error
    })
  }
  
  # Combine all tibbles into one and remove duplicates
  detailed_data <- bind_rows(detailed_data_list) %>% unique()
  
  return(detailed_data)
}


#  This function download the data for each study based on the study DOIs
access_data <- function(doi) {
  Acess_data_url <- "https://borealisdata.ca/api/access/dataset/"

  # Full URL construction and file path setup
  full_url3 <- paste0(Acess_data_url, ":persistentId/?persistentId=", doi)
  # zip_path <- file.path(unique_dir, "downloaded_data.zip")

  # Make the API request and download the ZIP file
  tryCatch({
    response <- request(full_url3) %>%
      req_headers(`X-Dataverse-key`= Api_token) %>%
      req_perform()

    if (response$status_code == 200) {

      # Get the content of the response as a raw vector
      zip_content <- resp_body_raw(response)

      # Use tempfile to create a temporary file for the zip content
      temp_zip <- tempfile(fileext = ".zip")

      # Write the raw vector to the temporary file
      writeBin(zip_content, temp_zip)

      # Use a temporary directory to extract the files
      temp_unzip_dir <- tempfile()

      # Extract the files to the temporary directory
      unzip(temp_zip, exdir = temp_unzip_dir)

      # List files in the temporary directory
      file_list <- list.files(temp_unzip_dir, full.names = TRUE)

      # Clean up the temporary zip file
      unlink(temp_zip)

      # Process the files as needed (this example simply returns the list of files)
      return(file_list)
    }
    else {
      return(NULL)
    }

  }, error = function(e) {
    print("Restricted data not accessible.")
  })
}


# Function to filter for .txt file and .tab/.csv file in the filelist and extract just the basename
filter_filelist <- function(file_list, is_txt) {
  if (is_txt) {
    # Filter for .txt files with "README" in the basename
    filtered_files <- file_list[grep("REA.*\\.txt$", basename(file_list), ignore.case = TRUE)]
  } else {
    # Filter for .tab or .csv files
    filtered_files <- file_list[grep("(\\.tab$|\\.csv$)", basename(file_list), ignore.case = TRUE)]
  }
  return(filtered_files)
}

# Check if a column contains any letters
contains_letters <- function(x) {
  any(grepl("[a-zA-Z]", x))
}


# Create (or connect to) the SQLite database
get_db_conn <- function(db_file = "Explorer_cache") {
  dbConnect(SQLite(), db_file)
}


# --- Functions to Manage the SQLite Cache ---
# # The functions does the API, extracts new DOIs and updates the research data

cache_raw_data <- function(conn) {
  update_needed <- TRUE  # Assume we need an update unless proven otherwise
  
  # Check if update_info table exists and when it was last updated
  if ("update_info" %in% dbListTables(conn)) {
    update_info <- dbReadTable(conn, "update_info")
    if (nrow(update_info) > 0) {
      last_update <- as.POSIXct(update_info$last_update[1])
      time_diff <- difftime(Sys.time(), last_update, units = "hours")
      if (time_diff < 48) {
        update_needed <- FALSE
        message("Less than 48 hours since last update (", round(time_diff, 2), " hours). Using cached data.")
      }
    }
  }
  
  if (!update_needed && ("research_data" %in% dbListTables(conn))) {
    # Return cached data if no update is needed
    return(dbReadTable(conn, "research_data"))
  }
  
  message("Updating cache with new data...")
  
  # Step 1: Get all available dataset metadata
  all_info <- fetch_all_datasets(16)
  
  pidTitle <- all_info %>%
    select(persistent_id, College_Campus_Institution, Departments_ResearchCentres) %>%
    tibble()
  
  result_details <- fetch_study_details(pidTitle)
  
  # Step 2: Store or update the database
  new_rows <- tibble()  # Initialize to hold only new rows
  
  if (!"research_data" %in% dbListTables(conn)) {
    message("No existing data found. Initializing cache with fetched data.")
    dbWriteTable(conn, "research_data", result_details, overwrite = TRUE)
  } else {
    existing_data <- dbReadTable(conn, "research_data")
    existing_dois <- existing_data$DOI
    new_dois <- all_info$persistent_id
    
    # Filter for new DOIs
    new_dois_to_process <- new_dois[!(new_dois %in% existing_dois)]
    
    if (length(new_dois_to_process) > 0) {
      message("Found new DOIs: ", paste(new_dois_to_process, collapse = ", "))
      
      new_dois_df <- pidTitle %>% filter(persistent_id %in% new_dois_to_process)
      
      new_study_details <- fetch_study_details(new_dois_df)
      
      new_rows <- bind_rows(new_rows, new_study_details)
    } else {
      message("No new DOIs found.")
    }
    
    if (nrow(new_rows) > 0) {
      message("Appending ", nrow(new_rows), " new record(s) to the research_data table.")
      dbWriteTable(conn, "research_data", new_rows, append = TRUE)
    } else {
      message("No new records to append.")
    }
  }
  
  # Step 3: Update timestamp in update_info
  current_time <- tibble(last_update = as.character(Sys.time()))
  dbWriteTable(conn, "update_info", current_time, overwrite = TRUE)
  
  # Step 4: Return full cached dataset
  updated_data <- dbReadTable(conn, "research_data")
  return(updated_data)
}

# Function to extract and process nodes and edges for Keywords and Authors
process_and_cache_new_data <- function(raw_data, input_event_type, conn) {
  
  # Check input validity
  if (!(input_event_type %in% c("Keywords", "Authors"))) {
    stop("input_event_type must be either 'Keywords' or 'Authors'")
  }
  
  message("Processing all Dataverses...")
  
  all_data <- raw_data
  
  # Define table names
  table_prefix <- tolower(input_event_type)
  nodes_table <- paste0(table_prefix, "_node")
  edges_table <- paste0(table_prefix, "_edge")
  
  # Generate color palette (up to 20 unique colors)
  colors_set3 <- RColorBrewer::brewer.pal(12, "Set3")  # First 12 colors
  colors_paired <- RColorBrewer::brewer.pal(12, "Paired")  # Next 8 colors
  all_colors <- c(colors_set3, colors_paired)  # Combine to get 24 colors
  
  # Ensure color tables exist
  for (grouping_col in c("CollegeName", "DepartmentName")) {
    color_table <- paste0(tolower(gsub("Name", "", grouping_col)), "_colors")
    if (!DBI::dbExistsTable(conn, color_table)) {
      DBI::dbExecute(conn, sprintf("CREATE TABLE %s (%s TEXT PRIMARY KEY, Color TEXT)", color_table, grouping_col))
    }
    
    # Load and extend color mapping
    unique_groups <- unique(all_data[[grouping_col]])
    existing_colors <- DBI::dbReadTable(conn, color_table)
    existing_color_map <- setNames(existing_colors$Color, existing_colors[[grouping_col]])
    new_groups <- setdiff(unique_groups, names(existing_color_map))
    
    if (length(new_groups) > 0) {
      available_colors <- all_colors[seq_len(min(length(new_groups), length(all_colors)))]  # Adjust the color selection logic
      assigned_colors <- unique(existing_colors$Color)
      unused_colors <- setdiff(available_colors, assigned_colors)
      
      new_color_map <- setNames(rep(NA, length(new_groups)), new_groups)
      for (grp in new_groups) {
        new_color_map[[grp]] <- ifelse(length(unused_colors) > 0,
                                       unused_colors[1],
                                       sample(available_colors, 1))
        unused_colors <- unused_colors[-1]
      }
      
      new_colors_df <- tibble::tibble(!!grouping_col := names(new_color_map), Color = unname(new_color_map))
      DBI::dbWriteTable(conn, color_table, new_colors_df, append = TRUE, row.names = FALSE)
    }
  }
  
  # Reload updated color maps
  college_colors <- DBI::dbReadTable(conn, "college_colors") |> 
    dplyr::distinct(CollegeName, Color) |> 
    tibble::deframe()
  
  department_colors <- DBI::dbReadTable(conn, "department_colors") |> 
    dplyr::distinct(DepartmentName, Color) |> 
    tibble::deframe()
  
  # Process Keywords or Authors
  if (input_event_type == "Keywords") {
    events <- all_data$Keywords %>%
      stringr::str_split(";\\s*") %>%
      unlist() %>%
      na.omit() %>%
      stringr::str_replace_all("[^a-zA-Z0-9\\s-]", "") %>%
      stringr::str_squish() %>%
      stringr::str_to_title() %>%
      .[!grepl("\\bAgricultural Science(s)?\\b", ., ignore.case = TRUE)] %>%
      unique() %>%
      sort()
  } else {
    events <- all_data$Authors %>%
      stringr::str_split(";\\s*") %>%
      unlist() %>%
      na.omit() %>%
      sort() %>%
      stringr::str_replace_all("\\.", "") %>%
      stringr::str_to_title() %>%
      stringr::str_replace_all("\\b([A-Z])\\b", "") %>%
      unique() %>%
      stringr::str_trim()
  }
  
  # Create nodes
  nodes <- purrr::map_df(seq_along(events), function(i) {
    event <- events[i] %>%
      stringr::str_squish() %>%
      stringr::str_to_title()
    
    matched_papers <- all_data %>%
      dplyr::filter(stringr::str_detect(
        stringr::str_to_lower(.data[[input_event_type]]),
        fixed(stringr::str_to_lower(event))
      ))
    
    if (nrow(matched_papers) == 0) return(NULL)
    
    studies_count <- nrow(matched_papers)
    year_range <- paste(min(matched_papers$PublicationDate, na.rm = TRUE), "to",
                        max(matched_papers$PublicationDate, na.rm = TRUE))
    
    college_names <- unique(matched_papers$CollegeName)
    department_names <- unique(matched_papers$DepartmentName)
    
    # Assign color for College and Department
    if (length(college_names) > 1) {
      college_color <- "gray"
    } else {
      college_color <- unique(na.omit(college_colors[college_names]))
    }
    
    if (length(department_names) > 1) {
      department_color <- "gray"
    } else {
      department_color <- unique(na.omit(department_colors[department_names]))
    }
    
    tibble::tibble(
      label = event,
      node_group = input_event_type,
      title = paste("Study Count:", studies_count, "<br>", "Year Range:", year_range),
      CollegeName = paste(college_names, collapse = ", "),
      DepartmentName = paste(department_names, collapse = ", "),
      CollegeColor = college_color,
      DepartmentColor = department_color,
      study_count = studies_count,
      year_range = year_range,
      DOI = paste(unique(matched_papers$DOI), collapse = "; ")
    )
  }) %>%
    dplyr::mutate(label = stringr::str_squish(label)) %>%
    dplyr::group_by(label) %>%
    dplyr::summarise(
      node_group = first(node_group),
      title = first(title),
      CollegeColor = first(CollegeColor),
      DepartmentColor = first(DepartmentColor),
      CollegeName = paste(unique(CollegeName), collapse = ", "),
      DepartmentName = paste(unique(DepartmentName), collapse = ", "),
      study_count = sum(study_count, na.rm = TRUE),
      year_range = paste(unique(year_range), collapse = " | "),
      DOI = paste(unique(DOI), collapse = "; ")
    ) %>%
    dplyr::ungroup() 
  
  # Get the maximum existing id from the database (if table exists)
  if (DBI::dbExistsTable(conn, nodes_table)) {
    current_max_id <- DBI::dbGetQuery(conn, paste0("SELECT MAX(id) AS max_id FROM ", nodes_table))$max_id
    current_max_id <- ifelse(is.na(current_max_id), 0, current_max_id)
  } else {
    current_max_id <- 0
  }
  
  # Then assign new ids starting after the current maximum
  nodes <- nodes %>%
    dplyr::mutate(id = current_max_id + dplyr::row_number())
  
  
  # Create edges
  event_occurrences <- lapply(nodes$label, function(ev) which(grepl(ev, all_data[[input_event_type]], ignore.case = TRUE)))
  node_pairs <- combn(nrow(nodes), 2, simplify = FALSE)
  edges_list <- purrr::map(node_pairs, function(pair) {
    i <- pair[1]
    j <- pair[2]
    count <- length(intersect(event_occurrences[[i]], event_occurrences[[j]]))
    if (count > 0) tibble::tibble(from = nodes$id[i], to = nodes$id[j], weight = count) else NULL
  }) %>% purrr::compact()
  
  edges <- dplyr::bind_rows(edges_list)
  
  # Store to database
  DBI::dbWriteTable(conn, nodes_table, nodes, append = TRUE, row.names = FALSE)
  DBI::dbWriteTable(conn, edges_table, edges, append = TRUE, row.names = FALSE)
  
  message("Processing complete. Data stored in: ", nodes_table, " and ", edges_table)
}


