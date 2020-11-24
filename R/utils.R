#' Return JavaScript dependencies
#'
#' @return List with JavaScript dependencies of the package.
dependencies <- function() {
  Leaflet.Control.Opacity <- htmltools::htmlDependency(
    name = "Leaflet.Control.Opacity",
    version = "1.4",
    src = system.file("src/Leaflet.Control.Opacity/",
                      package = "leaflet.multiopacity"),
    script = "L.Control.Opacity.js",
    stylesheet = "L.Control.Opacity.css"
  )
  leafletR.utils <- htmltools::htmlDependency(
    name = "leafletR.utils",
    version = "0.1.0",
    src = system.file("src/leafletR.utils/",
                      package = "leaflet.multiopacity"),
    script = "leafletR.utils.js"
  )
  return(list(Leaflet.Control.Opacity, leafletR.utils))
}

#' Register Plugin to leaflet map
#'
#' @param map
#' The map to register the plugin.
#' @param plugin
#' List with JavaScript dependencies (from 'htmltools::htmlDependency')
#' to register.
#'
#' @return
#' Leaflet map with plugin registered (JS dependencies added).
registerPlugin <- function(map, plugin) {
  map$dependencies <- c(map$dependencies, plugin)
  return(map)
}

#' Debug leaflet map
.leafletDebug <- function(map) {
  htmlwidgets::onRender(
    map,
    jsCode = JS("function(el, x) {
                  var map = this;
                  debugger;
                }")
  )
}
