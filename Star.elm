module Star exposing (drawStars)

import Collage exposing (oval, filled, group)
import Color exposing (rgb)

import Move exposing (moveTopLeft)

drawStars game =
  List.map (drawStar game) game.stars
  |> group

drawStar game star =
  let
    scalingFactorX = (toFloat game.window.width) / 100
    scalingFactorY = (toFloat game.window.height) / 100
    baseColor = floor (star.luminosity * 255)
    color = rgb (redStarColor star baseColor) baseColor (blueStarColor star baseColor)
  in
    oval star.size star.size
    |> filled color
    |> moveTopLeft game (star.x * scalingFactorX, star.y * scalingFactorY)

-- What I tried to do here was to have warm stars be blue, and less warm stars only more red to get a good mix of both
blueStarColor star baseColor =
  if star.warmth < 0.5 then
    baseColor
  else
    max ((toFloat baseColor) + (star.warmth * (toFloat 50))) (toFloat 255) |> floor

redStarColor star baseColor =
  if star.warmth > 0.5 then
    baseColor
  else
    max ((toFloat baseColor) + ((star.warmth * 2) * (toFloat 255))) (toFloat 255) |> floor
