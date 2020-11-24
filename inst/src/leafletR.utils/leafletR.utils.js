// #########################
// Utility Functions
// Meantrix
// #########################

// Coerce value into array
function asArray(value) {
  if (value === null)
    return [];
  if (Array.isArray(value))
    return value;
  return [value];
}

// Get all layers from map.layerManager._byStamp
function getAllLayers(ObjectByStamp) {
  var layerObjs = {};
  for (var i = 0; i < Object.keys(ObjectByStamp).length; i++) {
    var layer = Object.values(ObjectByStamp)[i];
    var layerId;
    if (layer.layerId === null) {
      layerId = layer.layer._leaflet_id;
    } else {
      layerId = layer.layerId;
    }
    var layerObj = {
      layerId: layerId, //layer.layerId,
      category: layer.category,
      group: layer.group,
      _leaflet_id: layer.layer._leaflet_id,
      layer: layer.layer
    };
    layerObjs[layerId] = layerObj;
  }
  return(layerObjs);
}

// Detect if text has some of searchWords
function multiSearchOr(text, searchWords) {
  if (text == null) return false;
  match = searchWords.map(el => "\\b" + el + "\\b").some(function(el) {
    return(text.match(new RegExp(el,"i")));
  });
  return match;
}

// Detect if text has all the searchWords
function multiSearchAnd(text, searchWords) {
  if (text == null) return false;
  match = searchWords.map(el => "\\b" + el + "\\b").every(function(el) {
    return(text.match(new RegExp(el,"i")));
  });
  return match;
}

// Subset allLayers by layerId(s)
function subsetByLayerId(allLayers, layerId) {
  var res;
  if (layerId === null) {
    res = Object.values(allLayers);
  } else {
    // Filter by layerId
    res = Object.values(allLayers).filter(
      function(p) {return(multiSearchOr(p.layerId, asArray(layerId)))}
    );
  }
  obj = {};
  for (i = 0; i < res.length; i++) {
    obj[res[i].layerId] = res[i].layer;
  }
  return(obj);
}

// Subset allLayers by group(s)
function subsetByGroup(allLayers, group) {
  var res;
  if (group === null) {
    res = Object.values(allLayers);
  } else {
    // Filter by group
    res = Object.values(allLayers).filter(
      function(p) {return(multiSearchOr(p.group, asArray(group)))}
    );
  }
  obj = {};
  for (i = 0; i < res.length; i++) {
    obj[res[i].layerId] = res[i].layer;
  }
  return(obj);
}

// Subset allLayers by category(ies)
function subsetByCategory(allLayers, category) {
  var res;
  if (category === null) {
    res = Object.values(allLayers);
  } else {
    // Filter by category
    res = Object.values(allLayers).filter(
      function(p) {return(multiSearchOr(p.category, asArray(category)))}
    );
  }
  obj = {};
  for (i = 0; i < res.length; i++) {
    obj[res[i].layerId] = res[i].layer;
  }
  return(obj);
}

