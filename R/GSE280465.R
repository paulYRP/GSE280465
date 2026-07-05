GSE280465 <- function(metadata = FALSE,
    filterBy = "GSE280465_GPL33022_EPICv2") {
    hub <- ExperimentHub::ExperimentHub()

    if (metadata) {
        return(ExperimentHub::listResources(
            hub, "GSE280465", filterBy = filterBy))
    }

    resources <- ExperimentHub::loadResources(
        hub, "GSE280465", filterBy = filterBy)

    if (!length(resources)) {
        stop(
            "No GSE280465 ExperimentHub resources were found. ",
            "The resource may not yet be available in the active ",
            "ExperimentHub snapshot.",
            call. = FALSE
        )
    }

    if (length(resources) != 1L) {
        stop(
            "Expected one GSE280465 resource but found ",
            length(resources), ". Use metadata = TRUE to inspect matches.",
            call. = FALSE
        )
    }

    resources[[1L]]
}
