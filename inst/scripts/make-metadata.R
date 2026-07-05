meta <- data.frame(
    Title = "GSE280465_GPL33022_EPICv2",
    Description = paste(
        "Processed adult cross-tissue DNA methylation data from GEO accession",
        "GSE280465. The resource is represented as a",
        "RangedSummarizedExperiment with beta, M, and CN assays for 163",
        "samples from 47 individuals across buccal, dried blood spot,",
        "peripheral blood mononuclear cell, and saliva tissues."
    ),
    BiocVersion = "3.24",
    Genome = "hg38",
    SourceType = "IDAT",
    SourceUrl = "https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE280465",
    SourceVersion = "Feb 07 2025",
    Species = "Homo sapiens",
    TaxonomyId = 9606L,
    Coordinate_1_based = TRUE,
    DataProvider = "GEO",
    Maintainer = "Paul Ruiz Pinto <ruizpint@qut.edu.au>",
    RDataClass = "RangedSummarizedExperiment",
    DispatchClass = "Rds",
    RDataPath = "records/21200586/files/GSE280465_GPL33022_EPICv2.rds",
    Location_Prefix = "https://zenodo.org/",
    Tags = paste(
        c(
            "GSE280465",
            "GPL33022",
            "EPICv2",
            "DNAMethylation",
            "MethylationArray",
            "ExperimentHub",
            "SummarizedExperiment",
            "RangedSummarizedExperiment"
        ),
        collapse = ":"
    ),
    Notes = paste(
        "Zenodo DOI 10.5281/zenodo.21200586; source publication DOI",
        "10.1111/acel.14451; adult-only GSE280465 processed resource."
    )
)

write.csv(meta, file = "inst/extdata/metadata.csv", row.names = FALSE)
