## leaflet.multiopacity <a href='http://meantrix.com'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!--
# leaflet.multiopacity
<a href='http://meantrix.com'><img src='man/figures/header.png'/> 
-->

<!-- badges: start -->
[![version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://semver.org)
[![CRAN status](https://www.r-pkg.org/badges/version/leaflet.multiopacity)](https://CRAN.R-project.org/package=leaflet.multiopacity)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Codecov test coverage](https://codecov.io/gh/meantrix/leaflet.multiopacity/branch/main/graph/badge.svg)](https://codecov.io/gh/meantrix/leaflet.multiopacity?branch=main)
[![R build status](https://github.com/meantrix/leaflet.multiopacity/workflows/R-CMD-check/badge.svg)](https://github.com/meantrix/leaflet.multiopacity/actions)
<!-- badges: end -->

### Overview

Extends Leaflet for R by adding widget to control opacity of multiple layers, based on **Leaflet.Control.Opacity** ([dayjournal/Leaflet.Control.Opacity](https://github.com/dayjournal/Leaflet.Control.Opacity)) JavaScript plugin with some modifications to support layers other than tile layers (currently tested: tile, image and marker).

### Installation

Before you begin, ensure you have met the following requirement(s):

- You have `R >= 3.5.0` installed.

Install the latest version released on CRAN:

```r
install.packages("leaflet.multiopacity")
```

Or install the development version from GitHub:

```r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("meantrix/leaflet.multiopacity@main")
```

### Basic Usage

`leaflet.multiopacity` provides the function `addOpacityControls` to include opacity sliders in leaflet map.

```r
# Load libraries
library(leaflet)
library(leaflet.multiopacity)
library(raster)

# Create raster example
r <- raster(xmn = -2.8, xmx = -2.79,
            ymn = 54.04, ymx = 54.05,
            nrows = 30, ncols = 30)
values(r) <- matrix(1:900, nrow(r), ncol(r), byrow = TRUE)
crs(r) <- crs("+init=epsg:4326")

# Provide layerId, group or category to show opacity controls
# If not specified, will render controls for all layers
leaflet() %>%
  addProviderTiles("Wikimedia", layerId = "Wikimedia") %>%
  addRasterImage(r, layerId = "raster") %>%
  addAwesomeMarkers(lng = -2.79545, lat = 54.04321,
                    layerId = "hospital", label = "Hospital") %>%
  addOpacityControls(layerId = c("raster", "hospital"),
                     collapsed = FALSE, position = "topright",
                     title = "Opacity Control")
```

For more information and examples, please take a look at the vignettes:

[Usage with leaflet](https://meantrix.github.io/leaflet.multiopacity/articles/usage-leaflet.html)  

[Usage with leafletProxy](https://meantrix.github.io/leaflet.multiopacity/articles/usage-leafletProxy.html)

### Contributing to leaflet.multiopacity

To contribute to `leaflet.multiopacity`, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin leaflet.multiopacity/<location>`
5. Create the pull request.

Alternatively see the GitHub documentation on [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

### Bug Reports

If you have detected a bug (or want to ask for a new feature), please file an issue with a minimal [reproducible example](https://www.tidyverse.org/help/#reprex) on [GitHub](https://github.com/meantrix/leaflet.multiopacity/issues).

### License

This project uses the following license: [MIT License](<https://github.com/meantrix/leaflet.multiopacity/blob/master/LICENSE>).
