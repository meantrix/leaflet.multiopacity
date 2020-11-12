// #########################
// Utility Functions
// Meantrix
// #########################

const clone = (obj) => Object.assign({}, obj);

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

// Get all layers from map.layerManager._byStamp
function getAllLayers(ObjectByStamp) {
  const clonedObj = clone(ObjectByStamp);
  //var layerObjs = [];
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
    //layerObjs.push({[layer.layerId]: layerObj})
    layerObjs[layer.layerId] = layerObj;
  }
  return(layerObjs);
}

// Detect if text has some of searchWords
function multiSearchOr(text, searchWords) {
  var match2 = searchWords.map(el => "\\b" + el + "\\b").some(function(el) {
    var match = text.match(new RegExp(el,"i"));
    return(match);
  });
  return(match2);
}

// Detect if text has all the searchWords
function multiSearchAnd(text, searchWords) {
  match2 = searchWords.map(el => "\\b" + el + "\\b").every(function(el) {
    var match = text.match(new RegExp(el,"i"));
    return(match);
  });
  return(match2);
}

// Subset allLayers by layerId(s)
function subsetByLayerId(allLayers, layerId) {
  // Filter by layerId
  var res = Object.values(allLayers).filter(
    function(p) {return(multiSearchOr(p.layerId, asArray(layerId)))}
  );
  obj = {};
  for (i = 0; i < res.length; i++) {
    obj[res[i].layerId] = res[i].layer;
  }
  return(obj);
}

// Subset allLayers by group(s)
function subsetByGroup(allLayers, group) {
  // Filter by group
  var res = Object.values(allLayers).filter(
    function(p) {return(multiSearchOr(p.group, asArray(group)))}
  );
  obj = {};
  for (i = 0; i < res.length; i++) {
    obj[res[i].layerId] = res[i].layer;
  }
  return(obj);
}

// Subset allLayers by category(ies)
function subsetByCategory(allLayers, category) {
  // Filter by category
  var res = Object.values(allLayers).filter(
    function(p) {return(multiSearchOr(p.category, asArray(category)))}
  );
  obj = {};
  for (i = 0; i < res.length; i++) {
    obj[res[i].layerId] = res[i].layer;
  }
  return(obj);
}

