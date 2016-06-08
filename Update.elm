module Update exposing (..)

import Window
import Keyboard
import Random

type Msg = Keypress Keyboard.KeyCode
         | TimeDiffSinceLastFrame Float
         | TwinkleStar Float
         | WindowResize Window.Size
         | RandomStarData (List ((Float, Float), (Float, Float, Float)))
         | RandomStarTwinkles (List Float)

update msg game =
  case msg of
    WindowResize size ->
      ({ game | window = size }, Cmd.none)
    TimeDiffSinceLastFrame frameTimeDiff ->
      (updateGameState game frameTimeDiff, Cmd.none)
    TwinkleStar _ ->
      (game, Random.generate RandomStarTwinkles (Random.list 300 <| Random.float 0.0 1.4))
    RandomStarTwinkles list ->
      (updateStarTwinkles game list, Cmd.none)
    RandomStarData starData ->
      (addStars game starData, Cmd.none)
    _ ->
      (game, Cmd.none)

updateGameState game frameTimeDiff =
  let
    delta = 1 / (1000 / frameTimeDiff)
  in
    game
    |> applyVelocityToPlanets delta
    |> applyGravityToPlanets delta
    |> rotatePlanetsTowardSun

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
  if (source.x == target.x && source.y == target.y) || (target.x == 0 && target.y == 0) then
     target
  else
    { target |
      vx = target.vx + 7800000 * ((directionFromSourceToTarget source target) |> degrees |> sin) * delta * source.gravity * (gravityDistance source target),
      vy = target.vy - 7800000 * ((directionFromSourceToTarget source target) |> degrees |> cos) * delta * source.gravity * (gravityDistance source target)
    }

rotatePlanetsTowardSun game =
  let
    planets = List.map (rotatePlanetTowardSun game) game.planets
  in
    { game | planets = planets }

rotatePlanetTowardSun game planet =
  { planet | rotation = (directionToSun planet |> degrees) }

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

directionFromSourceToTarget source target =
  let
    radians = atan2 (source.x - target.x) (target.y - source.y)
  in
    (radians * 180) / pi

directionToSun source =
  directionFromSourceToTarget source { x = -1000, y = 1000 }

addStars game starData =
  let
    stars = starData |> List.map buildStar
  in
    { game | stars = stars }

buildStar ((x, y), (size, luminosity, warmth)) =
  { x = x, y = y, size = size, luminosity = luminosity, startLuminosity = luminosity, warmth = warmth }

updateStarTwinkles game list =
  let
    stars = List.map2 (,) game.stars list
            |> List.map updateStarTwinkle
  in
    { game | stars = stars }

updateStarTwinkle (star, randomValue) =
  -- only update some of the stars each time
  if randomValue > 1.37 then
    { star | luminosity = star.startLuminosity * randomValue * 10 }
  else
    { star | luminosity = star.startLuminosity }
