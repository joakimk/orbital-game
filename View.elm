module View exposing (view)

import Collage exposing (collage, rect, filled, group, toForm, move, rotate)
import Element exposing (toHtml, image)
import Color exposing (grayscale)

import Star exposing (drawStars)
import LazyForm exposing (lazyForm)

view game =
  collage game.window.width game.window.height [
    lazyForm drawBackground game.window
  , lazyForm drawStars (game.window, game.stars)
  , drawPlanets game -- planets change too much to lazyRender
  ]
  |> toHtml

drawBackground window =
  rect (toFloat window.width) (toFloat window.height)
  |> filled (grayscale 1)

drawPlanets game =
  List.map (lazyForm drawPlanet) game.planets
  |> group

drawPlanet planet =
  let
    size = planet.size |> floor
  in
    image size size ("textures/" ++ planet.texture ++ ".png")
    |> toForm
    |> rotate planet.rotation
    |> move (planet.x, planet.y)
