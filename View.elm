module View exposing (view)

import Collage exposing (collage, rect, filled, group, toForm, move)
import Element exposing (toHtml, image)
import Color exposing (grayscale)

import Star exposing (drawStars)

view game =
  collage game.window.width game.window.height [
    drawBackground game
  , drawStars game
  , drawPlanets game
  ]
  |> toHtml

drawBackground game =
  rect (toFloat game.window.width) (toFloat game.window.height)
  |> filled (grayscale 1)

drawPlanets game =
  List.map (drawPlanet game) game.planets
  |> group

drawPlanet game planet =
  let
    size = planet.size |> floor
  in
    image size size ("textures/" ++ planet.texture ++ ".png")
    |> toForm
    |> move (planet.x, planet.y)


