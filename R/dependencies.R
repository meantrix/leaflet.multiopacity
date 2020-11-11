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

registerPlugin <- function(map, plugin) {
  map$dependencies <- c(map$dependencies, plugin)
  return(map)
}
