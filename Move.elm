module Move exposing (moveTopLeft)

import Collage exposing (move)

moveTopLeft game (x, y) form =
  let
    windowX = x - (toFloat game.window.width) / 2
    windowY = y - (toFloat game.window.height) / 2
  in
    form
    |> move (windowX, -windowY)


