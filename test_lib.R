# Install required packages if not present
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

# Install the local version of the package
devtools::install_local(".", force = TRUE)

# Load the package
library(tombRaiderWrapper)

# Test the example run
tombRaider_example_run()

# Test with custom parameters using example files
run_tombRaider(
  criteria = "taxId;seqSim;coOccur",
  frequency_input = "tombRaider/exampleFiles/zotutabweb.txt",
  sequence_input = "tombRaider/exampleFiles/zotus.fasta",
  taxonomy_input = "tombRaider/exampleFiles/blastTaxonomy.txt",
  frequency_output = "output/countTableNew.txt",
  sequence_output = "output/sequencesNew.fasta",
  taxonomy_output = "output/blastnResultsNew.txt",
  log = "output/log.txt",
  occurrence_type = "abundance",
  occurrence_ratio = "count;0",
  sort = "total read count",
  similarity = 90,
  blast_format = "6 qaccver saccver ssciname staxid length pident mismatch qcovs evalue bitscore qstart qend sstart send gapopen"
)
