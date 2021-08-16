# reads sql from file
getSQL <- function (filepath) {
  con = file(filepath, "r")
  sql.string <- ""
  while ( TRUE ) {
    line <- readLines(con, n = 1)
    if ( length(line) == 0 ){
      break
    }
    line <- gsub("\\t", " ", line)
    if(grepl("--",line) == TRUE){
      line <- paste(sub("--","/*",line),"*/")
    }
    sql.string <- paste(sql.string, line)
  }
  close(con)
  return(sql.string)
}

# group data
groupData <- function (data, group_by_cols) {
    options(warn=-1)
    grouped_data <- data %>% 
        group_by(.dots = group_by_cols) %>% 
        summarize(quantity = sum(quantity), .groups = 'drop')
    options(warn=0)
    return(grouped_data)
    
}

# forecast xreg
get_xreg <- function (data, col_name, horizon, forecast_start_date=snapshot_date, sheet_name, cell_range) {
    forecasted_xreg <- data %>%
        select(.dots = col_name) %>%
        model(arima=ARIMA(),
              ets=ETS()) %>%
        mutate(ensemble=(arima+ets)/2) %>%
        forecast(h = paste0(horizon," days")) %>%
        as_tibble() %>%
        filter(.model=="ensemble" &
               date>forecast_start_date & 
               date<=forecast_start_date+horizon) %>%
        select(.mean) %>%
        t() %>%
        as_tibble()
    range_write("https://docs.google.com/spreadsheets/d/1WWkWd26rDJMr9IvprQpe3_kh0CPO7t0QI72Pixa-At8/edit#gid=1748424073",
                sheet=sheet_name,
                data=forecasted_xreg,
                range = cell_range,
                col_names = FALSE,
                reformat = FALSE)
}