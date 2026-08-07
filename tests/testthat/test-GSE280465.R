test_that("GSE280465 returns the single matching resource", {
    hub <- new.env(parent = emptyenv())
    resource <- structure(list(), class = "GSE280465_test_resource")

    local_mocked_bindings(
        ExperimentHub = function() hub,
        loadResources = function(x, package, filterBy) {
            expect_identical(x, hub)
            expect_identical(package, "GSE280465")
            expect_identical(filterBy, "GSE280465_GPL33022_EPICv2")
            list(resource)
        },
        .package = "ExperimentHub"
    )

    expect_identical(GSE280465(), resource)
})

test_that("GSE280465 returns metadata without loading the resource", {
    hub <- new.env(parent = emptyenv())
    expected <- data.frame(Title = "GSE280465_GPL33022_EPICv2")

    local_mocked_bindings(
        ExperimentHub = function() hub,
        listResources = function(x, package, filterBy) {
            expect_identical(x, hub)
            expect_identical(package, "GSE280465")
            expect_identical(filterBy, "custom_title")
            expected
        },
        loadResources = function(...) {
            fail("loadResources() should not be called when metadata = TRUE")
        },
        .package = "ExperimentHub"
    )

    expect_identical(
        GSE280465(metadata = TRUE, filterBy = "custom_title"),
        expected
    )
})

test_that("GSE280465 reports missing and ambiguous resources", {
    hub <- new.env(parent = emptyenv())

    local_mocked_bindings(
        ExperimentHub = function() hub,
        loadResources = function(...) list(),
        .package = "ExperimentHub"
    )
    expect_error(
        GSE280465(),
        "No GSE280465 ExperimentHub resources were found",
        fixed = TRUE
    )

    local_mocked_bindings(
        ExperimentHub = function() hub,
        loadResources = function(...) list("first", "second"),
        .package = "ExperimentHub"
    )
    expect_error(
        GSE280465(),
        "Expected one GSE280465 resource but found 2",
        fixed = TRUE
    )
})
