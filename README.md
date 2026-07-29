[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21200586.svg)](https://doi.org/10.5281/zenodo.21200586)

# GSE280465

`GSE280465` is a Bioconductor ExperimentHub data package for the processed
adult EPICv2 DNA methylation resource derived from GEO accession GSE280465.

The hosted resource is a `RangedSummarizedExperiment` with beta, M, and CN
assays for 163 adult samples from 47 individuals across buccal, saliva, dried
blood spot, and peripheral blood mononuclear cell tissues.

The data are hosted on Zenodo:

https://zenodo.org/records/21200586

The source GEO record is:

https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE280465

The resource can be loaded with:

```r
library(ExperimentHub)
hub <- ExperimentHub()
query(hub, "GSE280465")
```

or through the package helper:

```r
library(GSE280465)
se <- GSE280465()
```
