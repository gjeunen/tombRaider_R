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

#' Run tombRaider with example files
#' @export
tombRaider_example_run <- function() {
  setup_python_env()
  setup_tombRaider()
  python_bin <- virtualenv_python("r-reticulate")
  command <- paste(shQuote(python_bin), file.path("tombRaider", "tombRaider"), "--example-run")
  system(command)
}

#' Run tombRaider with custom parameters
#' @param criteria A string separated by ';' of included criteria to identify parent-child combos: 'taxID', 'seqSim', 'coOccur', 'pseudogene'
#' @param discard_artefacts Logical, whether to discard rather than merge artefacts with parent sequences
#' @param frequency_input Frequency table input file name
#' @param sequence_input Sequence input file name
#' @param taxonomy_input Taxonomy input file name
#' @param alignment_input Alignment input file name
#' @param frequency_output Frequency table output file name
#' @param sequence_output Sequence output file name
#' @param taxonomy_output Taxonomy output file name
#' @param log Log output file name
#' @param transpose Logical, transpose 'frequency-input' to set taxa as rows
#' @param omit_rows A list of row labels to drop from the frequency table
#' @param omit_columns A list of column labels to drop from the frequency table
#' @param occurrence_type Data structure type to assess co-occurrence pattern: 'presence-absence' or 'abundance'
#' @param occurrence_ratio Ratio type and value for co-occurrence pattern to hold true: 'global;1.0', 'local;1.0', or 'count;1'
#' @param detection_threshold Detection threshold to consider true detection (default: 0)
#' @param exclude List of samples to exclude from the analysis
#' @param sort OTU/ASV sorting method: 'total read count', 'average read count', 'detections'
#' @param similarity Sequence similarity threshold between child and parent
#' @param pairwise_alignment 'global' (default) or 'local' alignment algorithm
#' @param blast_format Format of 'blast-input' file as provided to parameter 'outfmt' in blastn
#' @param bold_format 'bold-input' file format: 'summary', 'complete'
#' @param sintax_threshold Set sintax id and similarity to threshold column
#' @param taxon_quality Requires taxonomic assignment score of parent >= child
#' @param use_accession_id Set accession number as taxonomic ID (for intraspecific variation)
#' @param orf Start position of the open reading frame
#' @param calculate_pairwise Exclude 'alignment-input' for sequence similarity
#' @export
run_tombRaider <- function(
  criteria = NULL,
  discard_artefacts = NULL,
  frequency_input = NULL,
  sequence_input = NULL,
  taxonomy_input = NULL,
  alignment_input = NULL,
  frequency_output = NULL,
  sequence_output = NULL,
  taxonomy_output = NULL,
  log = NULL,
  transpose = NULL,
  omit_rows = NULL,
  omit_columns = NULL,
  occurrence_type = NULL,
  occurrence_ratio = NULL,
  detection_threshold = NULL,
  exclude = NULL,
  sort = NULL,
  similarity = NULL,
  pairwise_alignment = NULL,
  blast_format = NULL,
  bold_format = NULL,
  sintax_threshold = NULL,
  taxon_quality = NULL,
  use_accession_id = NULL,
  orf = NULL,
  calculate_pairwise = NULL
) {
  setup_python_env()
  setup_tombRaider()
  
  # Get the path to the Python interpreter in the virtual environment
  python_bin <- virtualenv_python("r-reticulate")
  
  # Build the command line arguments
  args <- character()
  
  # Helper function to add arguments
  add_arg <- function(name, value) {
    if (!is.null(value)) {
      if (is.logical(value)) {
        if (value) args <<- c(args, paste0("--", gsub("_", "-", name)))
      } else {
        args <<- c(args, paste0("--", gsub("_", "-", name)), shQuote(as.character(value)))
      }
    }
  }
  
  # Add all arguments
  add_arg("criteria", criteria)
  add_arg("discard-artefacts", discard_artefacts)
  add_arg("frequency-input", frequency_input)
  add_arg("sequence-input", sequence_input)
  add_arg("taxonomy-input", taxonomy_input)
  add_arg("alignment-input", alignment_input)
  add_arg("frequency-output", frequency_output)
  add_arg("sequence-output", sequence_output)
  add_arg("taxonomy-output", taxonomy_output)
  add_arg("log", log)
  add_arg("transpose", transpose)
  add_arg("omit-rows", omit_rows)
  add_arg("omit-columns", omit_columns)
  add_arg("occurrence-type", occurrence_type)
  add_arg("occurrence-ratio", occurrence_ratio)
  add_arg("detection-threshold", detection_threshold)
  add_arg("exclude", exclude)
  add_arg("sort", sort)
  add_arg("similarity", similarity)
  add_arg("pairwise-alignment", pairwise_alignment)
  add_arg("blast-format", blast_format)
  add_arg("bold-format", bold_format)
  add_arg("sintax-threshold", sintax_threshold)
  add_arg("taxon-quality", taxon_quality)
  add_arg("use-accession-id", use_accession_id)
  add_arg("orf", orf)
  add_arg("calculate-pairwise", calculate_pairwise)
  
  # Run the command
  command <- paste(shQuote(python_bin), file.path("tombRaider", "tombRaider"), paste(args, collapse = " "))
  system(command)
}
