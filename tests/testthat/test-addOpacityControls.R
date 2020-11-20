test_that("addOpacityControls dependencies are included in leaflet map", {
  # Create artificial layer
  r <- raster::raster(xmn = -2.8, xmx = -2.79, ymn = 54.04, ymx = 54.05, nrows = 30, ncols = 30)
  raster::values(r) <- matrix(1:900, nrow(r), ncol(r), byrow = TRUE)
  raster::crs(r) <- raster::crs("+init=epsg:4326")

  # Create leaflet map with multiopacity slider
  `%>%` <- magrittr::`%>%`
  map <- leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addRasterImage(r, layerId = "raster", project = FALSE) %>%
    addOpacityControls()

  expect_equal(map$dependencies[[1]]$name, "Leaflet.Control.Opacity")
  expect_equal(map$dependencies[[2]]$name, "leafletR.utils")
})

test_that("addOpacityControls JS function is registered on jsHooks", {
  # Create artificial layer
  r <- raster::raster(xmn = -2.8, xmx = -2.79, ymn = 54.04, ymx = 54.05, nrows = 30, ncols = 30)
  raster::values(r) <- matrix(1:900, nrow(r), ncol(r), byrow = TRUE)
  raster::crs(r) <- raster::crs("+init=epsg:4326")

  # Create leaflet map with opacity slider
  `%>%` <- magrittr::`%>%`
  map <- leaflet::leaflet() %>%
    leaflet::addTiles() %>%
    leaflet::addRasterImage(r, layerId = "raster", project = FALSE) %>%
    addOpacityControls()

  expect_match(map$jsHooks$render[[1]]$code[[1]], "function\\(el, x, data\\).*")
})

# test_that("addOpacityControls works with only map argument", {
#   addOpacityControls(leaflet::leaflet())
# })
