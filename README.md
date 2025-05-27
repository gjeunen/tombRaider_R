# tombRaiderWrapper

An R wrapper for the [tombRaider](https://github.com/gjeunen/tombRaider) tool, which is a taxon-dependent co-occurrence algorithm to identify and remove artefacts from metabarcoding datasets.

## Installation

To install the `tombRaiderWrapper` package from GitHub, you will need the `remotes` package. If you don't have `remotes` installed, you can install it using the following command:

```r
install.packages("remotes")
```
Once remotes is installed, you can install tombRaiderWrapper from the GitHub repository gjeunen/tombRaider_R:

```r
remotes::install_github("gjeunen/tombRaider_R")
```

## Usage

The wrapper provides two main functions:

1. `tombRaider_example_run()` - Runs tombRaider with example files
2. `run_tombRaider()` - Runs tombRaider with custom parameters

### Example Run

```r
library(tombRaiderWrapper)

# Run with example files
tombRaider_example_run()
```

### Custom Run

```r
library(tombRaiderWrapper)

# Run with custom parameters
run_tombRaider(
  criteria = "taxId;seqSim;coOccur",
  frequency_input = "path/to/your/countTable.txt",
  sequence_input = "path/to/your/sequences.fasta",
  taxonomy_input = "path/to/your/blastnResults.txt",
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
```

### Available Parameters

- `criteria`: A string separated by ';' of included criteria to identify parent-child combos: 'taxId', 'seqSim', 'coOccur', 'pseudogene'
- `frequency_input`: Frequency table input file name
- `sequence_input`: Sequence input file name
- `taxonomy_input`: Taxonomy input file name
- `frequency_output`: Frequency table output file name
- `sequence_output`: Sequence output file name
- `taxonomy_output`: Taxonomy output file name
- `log`: Log output file name
- `occurrence_type`: Data structure type to assess co-occurrence pattern: 'presence-absence' or 'abundance'
- `occurrence_ratio`: Ratio type and value for co-occurrence pattern to hold true: 'global;1.0', 'local;1.0', or 'count;1'
- `sort`: OTU/ASV sorting method: 'total read count', 'average read count', 'detections'
- `similarity`: Sequence similarity threshold between child and parent
- `blast_format`: Format of 'blast-input' file as provided to parameter 'outfmt' in blastn

## Requirements

- R >= 4.0.0
- Python >= 3.8
- Required Python packages: rich, rich-click, numpy, pandas

The wrapper will automatically set up a Python virtual environment and install required packages on first use.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
