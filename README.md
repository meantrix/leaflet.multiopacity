# leaflet.multiopacity <a href='http://meantrix.com'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- 
# leaflet.multiopacity
<a href='http://meantrix.com'><img src='man/figures/header.png'/> 
-->

<!-- badges: start -->
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Codecov test coverage](https://codecov.io/gh/meantrix/leaflet.multiopacity/branch/master/graph/badge.svg)](https://codecov.io/gh/meantrix/leaflet.multiopacity?branch=master)
[![version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://semver.org)
<!-- badges: end -->

  
Extends Leaflet for R by adding widget to control opacity of multiple layers, based on **Leaflet.Control.Opacity** ([dayjournal/Leaflet.Control.Opacity](https://github.com/dayjournal/Leaflet.Control.Opacity)) JS plugin with some modifications to support layers other than tile layers (currently tested: tile, image and marker).

## Prerequisites

Before you begin, ensure you have met the following requirement(s):

- You have `R >= 3.5.0` installed.

## Installation

This package is not yet released on CRAN. Meanwhile, you can install the latest stable version from Github with:

```r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("meantrix/leaflet.multiopacity@main")
```

## Basic Usage

`leaflet.multiopacity` provides the function `addOpacityControls` to include opacity sliders in leaflet map.

```r


```

## Contributing to leaflet.multiopacity

To contribute to `leaflet.multiopacity`, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin leaflet.multiopacity/<location>`
5. Create the pull request.

Alternatively see the GitHub documentation on [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

## Bug Reports

If you have detected a bug (or want to ask for a new feature), please file an issue with a minimal reproducible example on [GitHub](https://github.com/meantrix/leaflet.multiopacity/issues).

## License

This project uses the following license: [MIT Licence](<https://github.com/meantrix/leaflet.multiopacity/blob/master/LICENSE>).
