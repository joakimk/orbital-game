module Move exposing (moveTopLeft)

import Collage exposing (move)

moveTopLeft window (x, y) form =
  let
    windowX = x - (toFloat window.width) / 2
    windowY = y - (toFloat window.height) / 2
  in
    form
    |> move (windowX, -windowY)


