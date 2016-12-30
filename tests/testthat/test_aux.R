# tests for auxilarry functions

context("wp_linked_pages()")

test_that("wp_linked_pages() is robust against no-data, sparse data", {
  expect_error(
    {
      wikipediatrend::wp_linked_pages("Sheerness_Lifeboat_Station", lang="en")
    }, 
    NA
  )
})
