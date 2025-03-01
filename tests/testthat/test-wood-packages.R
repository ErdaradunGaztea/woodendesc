skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  packages <- wood_packages(repos = c("local#all", "cran", "bioc@1.8"))
})

httptest2::with_mock_api({
  colinfay_packages <- wood_packages(repos = "https://colinfay.me")
})

# TESTS ----
test_packages(packages)
test_param_repos(wood_packages())

test_that("uppercase in URL is preserved", {
  expect_not_empty(colinfay_packages)
})

skip_if_offline()
test_that("empty vector is returned if repository doesn't exist", {
  expect_equal(
    wood_packages(repos = "https://www.notanRrepo.com"),
    character()
  )
})
