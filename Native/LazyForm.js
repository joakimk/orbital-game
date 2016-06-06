var _user$project$Native_LazyForm = function() {
  var lazyCache = {}

  function lazy(data) {
    var cb = data._0;
    var a = data._1;

    var newKey = JSON.stringify(a);

    if(!lazyCache[cb] || lazyCache[cb].key != newKey) {
      //console.log("Rendering: " + cb);
      lazyCache[cb] = { data: cb(a), key: newKey }
    }

    return lazyCache[cb].data;
  };

  return {
    lazy: lazy
  };
}();
