### =========================================================================
### GSE280465 RangedSummarizedExperiment resource
### -------------------------------------------------------------------------
###
### This script documents the processing used to create the Zenodo-hosted
### ExperimentHub resource:
###
###   GSE280465_GPL33022_EPICv2.rds
###
### The large RDS file is not included in this package. It is hosted at:
###
###   https://zenodo.org/records/21200586
###
### Local inputs used by the maintainer:
###
###   data/preprocessingMinfiEwasWater/pheno_adult_tissue_epicv2.csv
###   hpc/rData/tissueEPICv2/preprocessingMinfiEwasWater/objects/GSet.RData
###   _/GSE280465_series_matrix.txt.gz
###
### The source GEO accession is:
###
###   https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE280465
###

suppressPackageStartupMessages({
    library(minfi)
    library(SummarizedExperiment)
    library(GenomicRanges)
    library(S4Vectors)
})

study_id <- "GSE280465"
platform_id <- "GPL33022"
array_name <- "Illumina Infinium MethylationEPIC version 2"
array_short_name <- "EPICv2"
genome_build <- "hg38"

pheno_file <- "data/preprocessingMinfiEwasWater/pheno_adult_tissue_epicv2.csv"
gset_file <- "hpc/rData/tissueEPICv2/preprocessingMinfiEwasWater/objects/GSet.RData"
rds_file <- "rds/GSE280465_GPL33022_EPICv2.rds"

dir.create(dirname(rds_file), recursive = TRUE, showWarnings = FALSE)

pheno <- read.csv(pheno_file, check.names = FALSE)

required_cols <- c(
    "GID", "Sample_Name", "Subject_ID", "Source", "Tissue", "Timepoint",
    "Sex", "Age", "Sentrix_ID", "Sentrix_Position", "Basename"
)

missing_cols <- setdiff(required_cols, names(pheno))
if (length(missing_cols)) {
    stop("Missing phenotype columns: ", paste(missing_cols, collapse = ", "))
}

stopifnot(!anyDuplicated(pheno$GID))
stopifnot(!anyDuplicated(pheno$Basename))

pheno$Sample_ID <- pheno$GID
pheno$SID <- pheno$Subject_ID
pheno$Array <- array_short_name
pheno$Platform <- platform_id
pheno$PlatformName <- array_name

front_cols <- c("Sample_ID", "SID")
pheno <- pheno[, c(front_cols, setdiff(names(pheno), front_cols))]

load(gset_file)

if (!inherits(GSet, "GenomicRatioSet")) {
    stop("The loaded GSet object is not a GenomicRatioSet.")
}

sample_names <- colnames(GSet)
if (!setequal(sample_names, pheno$Sample_ID)) {
    stop("Sample mismatch between GSet and phenotype table.")
}

pheno <- pheno[match(sample_names, pheno$Sample_ID), ]
stopifnot(identical(pheno$Sample_ID, sample_names))

beta <- minfi::getBeta(GSet)
m <- minfi::getM(GSet)
cn <- minfi::getCN(GSet)

stopifnot(identical(dim(beta), dim(m)))
stopifnot(identical(dim(beta), dim(cn)))
stopifnot(identical(rownames(beta), rownames(m)))
stopifnot(identical(rownames(beta), rownames(cn)))
stopifnot(identical(colnames(beta), pheno$Sample_ID))

row_ranges <- rowRanges(GSet)
stopifnot(length(row_ranges) == nrow(beta))

if (is.null(names(row_ranges))) {
    names(row_ranges) <- rownames(beta)
}

stopifnot(identical(names(row_ranges), rownames(beta)))
mcols(row_ranges)$CpG <- rownames(beta)

se <- SummarizedExperiment(
    assays = SimpleList(
        beta = beta,
        M = m,
        CN = cn
    ),
    rowRanges = row_ranges,
    colData = DataFrame(pheno, row.names = pheno$Sample_ID),
    metadata = list(
        title = "Cross-Tissue Comparison of Epigenetic Aging Clocks in Humans",
        geo_accession = study_id,
        platform = platform_id,
        array = array_name,
        array_short_name = array_short_name,
        annotation = "IlluminaHumanMethylationEPICv2anno.20a1.hg38",
        genome = genome_build,
        species = "Homo sapiens",
        tissue = paste(sort(unique(pheno$Tissue)), collapse = ", "),
        n_samples = ncol(beta),
        n_subjects = length(unique(pheno$SID)),
        phenotype_file = pheno_file,
        gset_file = gset_file,
        assays = c("beta", "M", "CN"),
        source_object = "GenomicRatioSet",
        object_name = "GSE280465_EPICv2",
        publication_doi = "10.1111/acel.14451",
        publication_pubmed_id = "39780748"
    )
)

stopifnot(inherits(se, "RangedSummarizedExperiment"))
stopifnot(identical(colnames(se), pheno$Sample_ID))
stopifnot(all(c("beta", "M", "CN") %in% assayNames(se)))

saveRDS(se, rds_file, compress = "xz")
