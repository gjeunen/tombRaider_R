#' Set up the Python environment and install required packages
#' @export
setup_python_env <- function() {
  # Ensure reticulate is loaded
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    stop("The reticulate package is required but not installed.")
  }
  library(reticulate)

  # Create and use a virtual environment named "r-reticulate"
  if (!virtualenv_exists("r-reticulate")) {
    virtualenv_create("r-reticulate")
    py_install(c("rich", "rich-click", "numpy", "pandas"), envname = "r-reticulate")
  }
  use_virtualenv("r-reticulate", required = TRUE)
}

#' Clone and set up tombRaider repository
#' @export
setup_tombRaider <- function() {
  if (!file.exists("tombRaider")) {
    system("git clone https://github.com/gjeunen/tombRaider.git")
    system("chmod +x tombRaider")
  }
  else {
    system('cd tombRaider')
    system('git pull')
    system('cd ..')
  }

  Sys.setenv(PATH = paste(Sys.getenv("PATH"), file.path(getwd(), file.path("tombRaider", "tombRaider")), sep = ":"))
}

#' Run tombRaider with specified arguments
#' @param args Command line arguments for tombRaider
#' @export
run_tombRaider <- function(args) {
  setup_python_env()
  setup_tombRaider()

  # Get the path to the Python interpreter in the virtual environment
  python_bin <- virtualenv_python("r-reticulate")

  # Run the tombRaider command using the virtual environment's Python
  command <- paste(shQuote(python_bin), file.path("tombRaider", "tombRaider"), args)
  system(command)
}

#' Run tombRaider with example files
#' @export
tombRaider_example_run <- function() {
  run_tombRaider("--example-run")
}

#' Run tombRaider with custom parameters
#' @param method Method to use
#' @param frequency_input Path to frequency input file
#' @param sequence_input Path to sequence input file
#' @param blast_input Path to BLAST input file
#' @param frequency_output Path to frequency output file
#' @param sequence_output Path to sequence output file
#' @param blast_output Path to BLAST output file
#' @param condensed_log Path to condensed log file
#' @param detailed_log Path to detailed log file
#' @param count Count parameter
#' @param sort Sort parameter
#' @export
run_tombRaider_custom <- function(method, frequency_input, sequence_input, blast_input, frequency_output, sequence_output, blast_output, condensed_log, detailed_log, count, sort) {
  args <- paste(
    "--method", method,
    "--frequency-input", frequency_input,
    "--sequence-input", sequence_input,
    "--blast-input", blast_input,
    "--frequency-output", frequency_output,
    "--sequence-output", sequence_output,
    "--blast-output", blast_output,
    "--condensed-log", condensed_log,
    "--detailed-log", detailed_log,
    "--count", count,
    "--sort", sort
  )
  run_tombRaider(args)
}
