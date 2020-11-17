// #########################
// Utility Functions
// Meantrix
// #########################

const clone = (obj) => Object.assign({}, obj);

/*
function removePrefix(ObjectLayers) {
  const clonedObj = clone(ObjectLayers);
  var array = Object.values(clonedObj);
  var old_keys = Object.keys(clonedObj);
  for (var i = 0; i < Object.keys(clonedObj).length; i++) {
    var old_key = old_keys[i];
    var new_key = old_keys[i].replace("tile\n", "").replace("image\n", "").replace("marker\n", "");
    if (old_key !== new_key) {
      Object.defineProperty(clonedObj, new_key,
                            Object.getOwnPropertyDescriptor(clonedObj, old_key));
      delete clonedObj[old_key];
    }
  }
  return(clonedObj);
}
*/

function asArray(value) {
  if (value === null)
    return [];
  if (Array.isArray(value))
    return value;
  return [value];
}

// Get all layers from map.layerManager._byStamp
function getAllLayers(ObjectByStamp) {
  const clonedObj = clone(ObjectByStamp);
  var layerObjs = {};
  for (var i = 0; i < Object.keys(clonedObj).length; i++) {
    var layer = Object.values(clonedObj)[i];
    var layerObj = {
      layerId: layer.layerId,
      category: layer.category,
      group: layer.group,
      _leaflet_id: layer.layer._leaflet_id,
      layer: layer.layer
    };
    layerObjs[layer.layerId] = layerObj;
  }
  return(layerObjs);
}

// Detect if text has some of searchWords
function multiSearchOr(text, searchWords) {
  match = searchWords.map(el => "\\b" + el + "\\b").some(function(el) {
    return(text.match(new RegExp(el,"i")));
  });
  return(match);
}

// Detect if text has all the searchWords
function multiSearchAnd(text, searchWords) {
  match = searchWords.map(el => "\\b" + el + "\\b").every(function(el) {
    return(text.match(new RegExp(el,"i")));
  });
  return(match);
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
  //debugger;
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

