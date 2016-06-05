module Update exposing (..)

import Window
import Keyboard

type Msg = Keypress Keyboard.KeyCode
         | TimeUpdate Float
         | WindowResize Window.Size
         | RandomStarData (List ((Float, Float), (Float, Float, Float)))

update msg game =
  let
    --x = Debug.log "Game" (toString game)
    --y = Debug.log "Msg" (toString msg)
    x = 0
  in
    case msg of
      WindowResize size ->
        ({ game | window = size }, Cmd.none)
      TimeUpdate time ->
        (updateGameState game, Cmd.none)
      RandomStarData starData ->
        (addStars game starData, Cmd.none)
      _ ->
        (game, Cmd.none)

updateGameState game =
  let
    delta = 1/60 -- todo: calculate this, or find where it got hidden in 0.17
  in
    game
    |> applyVelocityToPlanets delta
    |> applyGravityToPlanets delta

applyVelocityToPlanets delta game =
  let
    planets = List.map (\planet ->
      { planet | x = planet.x + planet.vx * delta, y = planet.y + planet.vy * delta }
    ) game.planets
  in
    { game | planets = planets }

applyGravityToPlanets delta game =
  let
    planets = List.map (applyGravity delta game) game.planets
  in
    { game | planets = planets }

applyGravity delta game planet =
  List.foldr (applyGravityToTarget delta) planet game.planets

applyGravityToTarget delta source target =
  if source == target || (target.vx == 0 && target.vy == 0) then
     target
  else
    { target |
      vx = target.vx + 900000 * ((directionToPlanet source target) |> degrees |> sin) * delta * source.gravity * (gravityDistance source target),
      vy = target.vy - 900000 * ((directionToPlanet source target) |> degrees |> cos) * delta * source.gravity * (gravityDistance source target)
    }

gravityDistance source target =
  let
    xd = (source.x - target.x)
    yd = (source.y - target.y)
    distance = (sqrt (xd*xd + yd*yd))
  in
    if distance == 0 then
       1
    else
      1 / (distance * distance)

directionToPlanet source target =
  let
    radians = atan2 (source.x - target.x) (target.y - source.y)
  in
    (radians * 180) / pi

addStars game starData =
  let
    stars = starData |> List.map buildStar
  in
    { game | stars = stars }

buildStar ((x, y), (size, luminosity, warmth)) =
  { x = x, y = y, size = size, luminosity = luminosity, warmth = warmth }
