module View exposing (view)

import Collage exposing (collage, rect, filled)
import Element exposing (toHtml)
import Color exposing (grayscale)

import Star exposing (drawStars)

view game =
  collage game.window.width game.window.height [
    drawBackground game
  , drawStars game
  ]
  |> toHtml

drawBackground game =
  rect (toFloat game.window.width) (toFloat game.window.height)
  |> filled (grayscale 1)

