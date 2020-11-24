test_that("addOpacityControls dependencies are included in leaflet map", {
  map <- addOpacityControls(leaflet::leaflet())
  expect_equal(map$dependencies[[1]]$name, "Leaflet.Control.Opacity")
  expect_equal(map$dependencies[[2]]$name, "leafletR.utils")
})

test_that("addOpacityControls JS function is registered on jsHooks", {
  map <- addOpacityControls(leaflet::leaflet())
  map2 <- addOpacityControls(leaflet::leaflet(), renderOnLayerAdd = TRUE)
  expect_match(map$jsHooks$render[[1]]$code[[1]], "function\\(el, x, data\\).*")
  expect_match(map2$jsHooks$render[[1]]$code[[1]], "function\\(el, x, data\\).*")
})
