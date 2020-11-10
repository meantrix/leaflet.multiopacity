dependency <- function() {
  Leaflet.Control.Opacity <- htmltools::htmlDependency(
    name = "Leaflet.Control.Opacity",
    version = "1.4",
    src = system.file("src/Leaflet.Control.Opacity/",
                      package = "leaflet.multiopacity"),
    script = "L.Control.Opacity.js",
    stylesheet = "L.Control.Opacity.css"
  )
  return(Leaflet.Control.Opacity)
}

registerPlugin <- function(map, plugin) {
  map$dependencies <- c(map$dependencies, list(plugin))
  return(map)
}

#' Add Opacity Controls
#'
#' @param map Leaflet map.
#'
#' @examples
#' # Load libraries
#' library(leaflet)
#' library(leaflet.multiopacity)
#' library(raster)
#'
#' # Create raster example
#' r <- raster(xmn = -2.8, xmx = -2.79, ymn = 54.04, ymx = 54.05, nrows = 30, ncols = 30)
#' values(r) <- matrix(1:900, nrow(r), ncol(r), byrow = TRUE)
#' crs(r) <- CRS("+init=epsg:4326")
#'
#' leaflet() %>%
#'   addTiles() %>%
#'   addRasterImage(r, layerId = "raster") %>%
#'   addOpacityControls(collapsed = FALSE, position = "topright", label = "Transparency")
#'
#' @export
addOpacityControls <- function(map, collapsed = FALSE,
                               position = c("topright",
                                            "topleft",
                                            "bottomright",
                                            "bottomleft"),
                               label = NULL) {

  position <- match.arg(position)
  stopifnot(inherits(collapsed, "logical"),
            length(collapsed) == 1)
  if (!is.null(label))
    stopifnot(inherits(label, "character"),
              length(label) == 1)

  data <- list(collapsed = collapsed,
               position = position,
               label = label)

  map %>%
    registerPlugin(dependency()) %>%
    htmlwidgets::onRender(
      .,
      # htmlwidgets::JS("function(el,x,data){
      #                  var map = this;
      #                  var opacitySlider = new L.Control.opacitySlider();
      #                  var opacityLayer = map.layerManager.getLayer('image', data.layerId)
      #
      #                  opacitySlider.setOpacityLayer(opacityLayer);
      #                  map.addControl(opacitySlider);
      #               }"),
      htmlwidgets::JS('function(el,x,data){
                       var map = this;
                       //debugger;
console.log("here1")

                      //AddLayer
                       //var Map_AddLayer = {
                       //"layer1": map.layerManager.getLayer("image", "raster1"),
                       //"layerteste": map.layerManager.getLayer("image", "raster2"),
                       //"layer3": map.layerManager.getLayer("image", "raster3")
                        //"layer1": map.layerManager._byGroup.overlay1,
                        //"layer2": map.layerManager._byGroup.overlay2,
                        //"layer3": map.layerManager._byGroup.overlay3
                       //};

console.log("here3")

//var tileLayer0 = map.layerManager._byLayerId[\'tile\\nstamen\'];
//var tileLayer1 = map.layerManager._byLayerId[\'tile\\nnone\'];
//var tileLayer1 = map.layerManager._byLayerId[\'tile\\nraster1\'];
//var tileLayer2 = map.layerManager._byLayerId[\'tile\\nraster2\'];
//var tileLayer3 = map.layerManager._byLayerId[\'tile\\nraster3\'];
var tileLayer1 = map.layerManager.getLayer("tile", "stamen")
var tileLayer2 = map.layerManager.getLayer("tile", "none")
var tileLayer3 = map.layerManager.getLayer("tile", "osm")
var tileLayer4 = map.layerManager.getLayer("tile", "otm")
//var tileLayer1 = map.layerManager.getLayer("image", "raster1")
//var tileLayer2 = map.layerManager.getLayer("image", "raster2")
//var tileLayer3 = map.layerManager.getLayer("image", "raster3")

debugger;

//console.log(tileLayer0)
//console.log(tileLayer1)
//console.log(tileLayer2)
//console.log(tileLayer3)

                       //OpacityControl
                       L.control.opacity(
                       //{"stamen": tileLayer1, "empty": tileLayer2},
                       {"stamen": tileLayer1, "empty": tileLayer2, "osm": tileLayer3, "otm": tileLayer4},
                       //{"raster1": tileLayer1, "raster2": tileLayer2, "raster3": tileLayer3},
                       //map.layerManager._byGroup,
                       options = {
                        collapsed: data.collapsed,
                        position: data.position,
                        label: data.label
                       }
                       ).addTo(map);

console.log("finish")

                    }'),
      data)

}

# Get baseTiles with
map.layerManager.getLayer("tile", "layerId")
# or
map.layerManager._byLayerId['tile\nlayerId']
# Get overlays (images) with
map.layerManager.getLayer("image", "layerId")
# or
map.layerManager._byLayerId['image\nraster1']

# Pass layer name
#map.layerManager.getLayer("stamen"),
#map.layerManager.getLayer("raster")

# Pass group name
#map.layerManager._byGroup.base,
#map.layerManager._byGroup.overlay,

# console.log("here2")
#
# //const m_color = new L.tileLayer("https://tile.mierune.co.jp/mierune/{z}/{x}/{y}.png", {
#   //    attribution: \'Maptiles by <a href="http://mierune.co.jp/" target="_blank">MIERUNE</a>, under CC BY. Data by <a href="http://osm.org/copyright" target="_blank">OpenStreetMap</a> contributors, under ODbL.\'
# //});
# //var rast1 = map.layerManager.getLayer("image", "raster1")
# //console.log(Object(m_color))
# //console.log(Object(rast1))
#
# //var layers = [];
# //map.eachLayer(function(layer) {
# //    if( layer instanceof L.TileLayer )
# //        layers.push(layer);
# //});
#
# console.log(map.layerManager._byGroup)
# //console.log(layers)

# var BaseTiles = {
#   "empty": map.layerManager._byGroup.empty,
#   "base": map.layerManager._byGroup.base
# }
#
# var OverlayTiles = {
#   "overlay1": map.layerManager._byGroup.overlay1,
#   "overlay2": map.layerManager._byGroup.overlay2,
#   "overlay3": map.layerManager._byGroup.overlay3
# }
#
# //LayerControl
# L.control.layers(
#   BaseTiles,
#   OverlayTiles,
#   options = {
#     collapsed: false
#   }
# ).addTo(map);

# //LayerControl
# L.control.layers(
#   map.layerManager._byGroup.base,
#   map.layerManager.getLayer("stamen"),
#   Map_AddLayer,
#   options = {
#     collapsed: false
#   }
# ).addTo(map);



# //LayerControl
# L.control.layers(
#   [
#     map.layerManager._byGroup.empty,
#     map.layerManager._byGroup.base
#   ],
#   [
#     map.layerManager._byGroup.overlay1,
#     map.layerManager._byGroup.overlay2,
#     map.layerManager._byGroup.overlay3
#   ],
#   options = {
#     collapsed: false
#   }
# ).addTo(map);


# addOpacityControls <- function(map, collapsed = FALSE,
#                                position = c("topright",
#                                             "topleft",
#                                             "bottomright",
#                                             "bottomleft"),
#                                label = NULL) {
#
#   position <- match.arg(position)
#   stopifnot(inherits(collapsed, "logical"),
#             length(collapsed) == 1)
#   if (!is.null(label))
#     stopifnot(inherits(label, "character"),
#               length(label) == 1)
#
#   # data <- list(layerId = layerId)
#
#   map <- map %>%
#     registerPlugin(dependency()) %>%
#     htmlwidgets::onRender(
#       .,
#       # htmlwidgets::JS("function(el,x,data){
#       #                  var map = this;
#       #                  var opacitySlider = new L.Control.opacitySlider();
#       #                  var opacityLayer = map.layerManager.getLayer('image', data.layerId)
#       #
#       #                  opacitySlider.setOpacityLayer(opacityLayer);
#       #                  map.addControl(opacitySlider);
#       #               }"),
#       htmlwidgets::JS('function(el,x,data){
#                        var map = this;
#
#                        //BaseLayer
#                        const Map_BaseLayer = {
#                        "MIERUNE Color": m_color,
#                        "MIERUNE MONO": m_mono
#                        };
#
#                        //AddLayer
#                        const Map_AddLayer = {
#                        "OSM": o_std,
#                        "GSI Pale": t_pale,
#                        "GSI Ort": t_ort
#                        };
#
#                        //LayerControl
#                        L.control.layers(
#                        "Stamen.TonerHybrid",
#                        {
#                        "raster",
#                        },
#                        options = {
#                         collapsed: false
#                        }
#                        ).addTo(map);
#
#                        //OpacityControl
#                        L.control.opacity(
#                        overlays = "raster",
#                        options = {
#                         label: "Layers Opacity"
#                        }
#                        ).addTo(map);
#
#                     }'),
#       data)
#
#   return(map)
#
# }
