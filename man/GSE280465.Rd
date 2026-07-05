\name{GSE280465}
\alias{GSE280465}
\alias{GSE280465_GPL33022_EPICv2}
\title{Load the GSE280465 ExperimentHub resource}
\usage{
GSE280465(metadata = FALSE, filterBy = "GSE280465_GPL33022_EPICv2")

GSE280465_GPL33022_EPICv2(metadata = FALSE)
}
\arguments{
\item{metadata}{\code{logical(1)}. If \code{TRUE}, return ExperimentHub
metadata for the matching resource. If \code{FALSE}, load the matching
resource.}
\item{filterBy}{\code{character(1)}. Resource title used to filter the
\pkg{ExperimentHub} entries for this package.}
}
\value{
When \code{metadata = FALSE}, a \code{RangedSummarizedExperiment}. When
\code{metadata = TRUE}, the matching ExperimentHub metadata.
}
\description{
Convenience helper for loading the GSE280465 EPICv2 adult cross-tissue DNA
methylation resource from \pkg{ExperimentHub}.
}
\details{
The resource is registered as \code{GSE280465_GPL33022_EPICv2} in
\pkg{ExperimentHub}. It contains beta, M, and CN assays with hg38 genomic
ranges and sample-level phenotype metadata.

The \code{GSE280465_GPL33022_EPICv2()} function is the resource-title
accessor generated from \file{inst/extdata/metadata.csv} when the package is
loaded. It returns the same hosted resource as \code{GSE280465()}.
}
\examples{
metadata_file <- system.file("extdata", "metadata.csv", package = "GSE280465")
metadata <- utils::read.csv(metadata_file, stringsAsFactors = FALSE)
metadata[, c("Title", "Genome", "RDataClass")]

if (interactive()) {
    library(GSE280465)
    GSE280465(metadata = TRUE)
    se <- GSE280465()
    se
    se <- GSE280465_GPL33022_EPICv2()
}
}
\seealso{
\code{\link[ExperimentHub]{ExperimentHub}},
\code{\link[ExperimentHub]{listResources}},
\code{\link[ExperimentHub]{loadResources}}
}
\keyword{datasets}
