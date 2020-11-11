const clone = (obj) => Object.assign({}, obj);

var removePrefix = function(ObjectLayers) {
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
};
