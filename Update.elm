module Update exposing (..)

import Window
import Keyboard

type Msg = Keypress Keyboard.KeyCode
         --| TimeUpdate Float
         | WindowResize Window.Size
         | RandomStarData (List ((Float, Float), (Float, Float, Float)))

update msg game =
  let
    x = Debug.log "Game" (toString game)
    y = Debug.log "Msg" (toString msg)
  in
    case msg of
      WindowResize size ->
        ({ game | window = size }, Cmd.none)
      RandomStarData starData ->
        (addStars game starData, Cmd.none)
      _ ->
        (game, Cmd.none)

addStars game starData =
  let
    stars = starData |> List.map buildStar
  in
    { game | stars = stars }

buildStar ((x, y), (size, luminosity, warmth)) =
  { x = x, y = y, size = size, luminosity = luminosity, warmth = warmth }
