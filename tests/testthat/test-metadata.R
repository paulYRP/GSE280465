test_that("ExperimentHub metadata has the required schema", {
    metadata_file <- system.file(
        "extdata", "metadata.csv",
        package = "GSE280465",
        mustWork = TRUE
    )
    metadata <- utils::read.csv(metadata_file, stringsAsFactors = FALSE)

    required_columns <- c(
        "Title", "Description", "BiocVersion", "Genome", "SourceType",
        "SourceUrl", "SourceVersion", "Species", "TaxonomyId",
        "Coordinate_1_based", "DataProvider", "Maintainer", "RDataClass",
        "DispatchClass", "RDataPath", "Location_Prefix", "Tags", "Notes"
    )

    expect_identical(nrow(metadata), 1L)
    expect_setequal(names(metadata), required_columns)
    expect_false(anyNA(metadata))
    expect_false(any(vapply(metadata, is.character, logical(1L)) &
        vapply(metadata, function(x) any(!nzchar(x)), logical(1L))))
})

test_that("ExperimentHub metadata describes the published resource", {
    metadata_file <- system.file(
        "extdata", "metadata.csv",
        package = "GSE280465",
        mustWork = TRUE
    )
    metadata <- utils::read.csv(metadata_file, stringsAsFactors = FALSE)

    expect_identical(metadata$Title, "GSE280465_GPL33022_EPICv2")
    expect_identical(metadata$Genome, "hg38")
    expect_identical(metadata$Species, "Homo sapiens")
    expect_identical(metadata$TaxonomyId, 9606L)
    expect_true(metadata$Coordinate_1_based)
    expect_identical(metadata$RDataClass, "RangedSummarizedExperiment")
    expect_identical(metadata$DispatchClass, "Rds")
    expect_match(metadata$SourceUrl, "GSE280465", fixed = TRUE)
    expect_match(metadata$Tags, "GSE280465", fixed = TRUE)

    resource_url <- paste0(metadata$Location_Prefix, metadata$RDataPath)
    expect_match(resource_url, "^https://zenodo\\.org/records/")
    expect_match(resource_url, "GSE280465_GPL33022_EPICv2\\.rds$")
})
