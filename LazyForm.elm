-- Experimental: cache form data when the source data does not
-- change. Like VirtualDom.lazy.

-- I've seen this change CPU from 100% to about 80% on my laptop without
-- changing anything visually.

module LazyForm exposing (lazyForm)

import Native.LazyForm

lazyForm renderCallback data =
  Native.LazyForm.lazy (renderCallback, data)

