#' Add Opacity Controls
#'
#' @param map
#' The map to add the opacity controls to.
#' @param category
#' One or more categories to render opacity controls to.
#' @param group
#' One or more groups to render opacity controls to.
#' @param layerId
#' One or more layer IDs to render opacity controls to.
#' @param collapsed
#' If FALSE (the default), the opacity control will always appear
#' in its expanded state. Set to TRUE to have the opacity control
#' rendered as an icon that expands when hovered over.
#' @param position
#' Position of control: "topleft", "topright", "bottomleft", or "bottomright".
#' @param title
#' The control title.
#' @param renderOnLayerAdd
#' When this argument is TRUE, the controls will only appear when a new
#' layer is added and rendered in the map. This can be useful if you plan
#' to use `leafletProxy` and need the controls to be dinamically updated.
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
#' crs(r) <- crs("+init=epsg:4326")
#'
#' # If layerId not specified, will show controls all layers
#' leaflet() %>%
#'   addProviderTiles("Wikimedia", layerId = "Wikimedia") %>%
#'   addRasterImage(r, layerId = "raster") %>%
#'   addAwesomeMarkers(lng = -2.79545, lat = 54.04321,
#'                     layerId = "hospital", label = "Hospital") %>%
#'   addOpacityControls(layerId = c("raster", "hospital"),
#'                      collapsed = FALSE, position = "topright",
#'                      title = "Opacity Control")
#'
#' @export
addOpacityControls <- function(map,
                               layerId = NULL,
                               category = NULL,
                               group = NULL,
                               collapsed = FALSE,
                               position = c(
                                 "topright",
                                 "topleft",
                                 "bottomright",
                                 "bottomleft"
                               ),
                               title = NULL,
                               renderOnLayerAdd = FALSE) {

  if (inherits(map, "leaflet_proxy"))
    stop("LeafletProxy is not supported. Please use this function with renderOnLayerAdd set to TRUE.")
  stopifnot(inherits(map, "leaflet"))
  if (!is.null(layerId)) stopifnot(inherits(layerId, "character"))
  if (!is.null(category)) stopifnot(inherits(category, "character"))
  if (!is.null(group)) stopifnot(inherits(group, "character"))
  stopifnot(inherits(collapsed, "logical"), length(collapsed) == 1)
  if (!is.null(title)) stopifnot(inherits(title, "character"), length(title) == 1)
  stopifnot(inherits(renderOnLayerAdd, "logical"), length(renderOnLayerAdd) == 1)
  position <- match.arg(position)

  if (isTRUE(collapsed) && !is.null(title)) {
    warning("Not possible to set control title when collapsed is TRUE.")
    title <- NULL
  }

  type <- .chooseType(layerId = layerId, category = category, group = group)

  data <- list(category = category,
               group = group,
               layerId = layerId,
               options = list(
                 type = type,
                 collapsed = collapsed,
                 position = position,
                 label = title
               ))

  map <- registerPlugin(map, dependencies())

  if (renderOnLayerAdd) {
    jsCode <- htmlwidgets::JS('
      function(el, x, data) {
        var multiopacityControl;
        var map = this;
        map.on("layeradd",
          function(e) {
            // remove previous multiopacityControl if it exists
            if (multiopacityControl !== undefined) {
              multiopacityControl.remove()
            }
            var allLayers = getAllLayers(map.layerManager._byStamp)
            var layers;
            switch (data.options.type) {
              case "category":
                layers = subsetByCategory(allLayers, data.category);
                break;
              case "group":
                layers = subsetByGroup(allLayers, data.group);
                break;
              case "layerId":
                layers = subsetByLayerId(allLayers, data.layerId);
                break;
              default:
                layers = allLayers;
                break;
            }
            //OpacityControl
              multiopacityControl = L.control.opacity(
                layers,
                options = {
                  collapsed: data.options.collapsed,
                  position: data.options.position,
                  label: data.options.label
                }
              ).addTo(map);
          }
        )
      }')
  } else {
    jsCode <- htmlwidgets::JS('
      function(el, x, data) {
        var multiopacityControl;
        var map = this;
        // remove previous multiopacityControl if it exists
        if (multiopacityControl !== undefined) {
          multiopacityControl.remove()
        }
        var allLayers = getAllLayers(map.layerManager._byStamp)
        switch (data.options.type) {
          case "category":
            var layers = subsetByCategory(allLayers, data.category);
            break;
          case "group":
            var layers = subsetByGroup(allLayers, data.group);
            break;
          case "layerId":
            var layers = subsetByLayerId(allLayers, data.layerId);
            break;
          default:
            break;
        }
        //OpacityControl
        multiopacityControl = L.control.opacity(
          layers,
          options = {
            collapsed: data.options.collapsed,
            position: data.options.position,
            label: data.options.label
          }
        ).addTo(map);
      }')
  }

  htmlwidgets::onRender(
    map,
    jsCode = jsCode,
    data = data)

}

.chooseType <- function(layerId = NULL, category = NULL, group = NULL) {
  idx <- sapply(list(layerId = layerId,
                     category = category,
                     group = group),
                function(x) !is.null(x))
  type <- names(which(idx))
  if (length(type) == 0) {
    message("No filter used, showing all layers.")
    type <- "none"
  } else if (length(type) > 1) {
    type <- type[1]
    warning(
      paste("It is not possible to pass more than",
            "one type (layerId, category or group).",
            "Using", type, "only."),
      call. = FALSE)
  }
  return(type)
}
