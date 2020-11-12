#' Add Opacity Controls
#'
#' @param map
#' The map to add the opacity controls to.
#' @param layerId
#' One or more layer IDs to render opacity controls to. If NULL (the default),
#' will create controls for all layers and graphical components.
#' @param collapsed
#' If FALSE (the default), the opacity control will always appear
#' in its expanded state. Set to TRUE to have the opacity control
#' rendered as an icon that expands when hovered over.
#' @param position
#' Position of control: "topleft", "topright", "bottomleft", or "bottomright".
#' @param label
#' The control title.
#'
#' @examples
#' # Load libraries
#' library(leaflet)
#' library(leaflet.multiopacity)
#' library(raster)
#'
#' # Create raster example
#' r <- raster(xmn = -2.8, xmx = -2.79,
#'             ymn = 54.04, ymx = 54.05,
#'             nrows = 30, ncols = 30)
#' values(r) <- matrix(1:900, nrow(r), ncol(r), byrow = TRUE)
#' crs(r) <- CRS("+init=epsg:4326")
#'
#' # If layerId not specified, will show controls all layers
#' leaflet() %>%
#'   addProviderTiles("Wikimedia", layerId = "Wikimedia") %>%
#'   addRasterImage(r, layerId = "raster") %>%
#'   addAwesomeMarkers(lng = -2.79545, lat = 54.04321, layerId = "hospital", label = "Hospital") %>%
#'   addOpacityControls(layerId = c("raster", "hospital"), collapsed = FALSE, position = "topright", label = "Opacity Control")
#'
#' @export
addOpacityControls <- function(map, layerId = NULL,
                               collapsed = FALSE,
                               position = c(
                                 "topright",
                                 "topleft",
                                 "bottomright",
                                 "bottomleft"
                               ),
                               label = NULL) {


  if (!is.null(layerId)) stopifnot(inherits(layerId, "character"))
  position <- match.arg(position)
  stopifnot(inherits(collapsed, "logical"),
            length(collapsed) == 1)
  if (!is.null(label))
    stopifnot(inherits(label, "character"),
              length(label) == 1)

  if (isTRUE(collapsed)) {
    warning("Not possible to set control label when collapsed is TRUE.")
    label <- NULL
  }

  data <- list(layerIds = layerId,
               options = list(
                 collapsed = collapsed,
                 position = position,
                 label = label
               ))

  map %>%
    registerPlugin(dependencies()) %>%
    htmlwidgets::onRender(
      htmlwidgets::JS(
        'function(el, x, data) {

        var map = this;

        //debugger;

        if (data.layerIds == null) {
        var layers = removePrefix(map.layerManager._byLayerId);
        } else {
        var allLayers = getAllLayers(map.layerManager._byStamp);
        var layers = subsetByLayerId(allLayers, data.layerIds);
        };

        //OpacityControl
        L.control.opacity(
          layers,
          //map.layerManager._byStamp,
          options = {
            collapsed: data.options.collapsed,
            position: data.options.position,
            label: data.options.label
          }
        ).addTo(map);

        }'), data)

}




# Subsetting by group or category (type)
# map.layerManager._byGroup.hospital
# map.layerManager._byCategory.image
# by type (another solution)
# map.layerManager._byLayer
# subset keynames (tile, image, marker)



