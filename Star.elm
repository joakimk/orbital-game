module Star exposing (drawStars)

import Collage exposing (Form, oval, filled, group)
import Color exposing (rgb)
import Move exposing (moveTopLeft)
import Window
import Model exposing (Star)


drawStars : ( Window.Size, List Star ) -> Form
drawStars ( window, stars ) =
    List.map (drawStar window) stars
        |> group


drawStar : Window.Size -> Star -> Form
drawStar window star =
    let
        scalingFactorX =
            (toFloat window.width) / 100

        scalingFactorY =
            (toFloat window.height) / 100

        baseColor =
            floor (star.luminosity * 255)

        color =
            rgb (redStarColor star baseColor) baseColor (blueStarColor star baseColor)
    in
        oval star.size star.size
            |> filled color
            |> moveTopLeft window ( star.x * scalingFactorX, star.y * scalingFactorY )



-- What I tried to do here was to have warm stars be blue, and less warm stars only more red to get a good mix of both


blueStarColor : Star -> Int -> Int
blueStarColor star baseColor =
    if star.warmth < 0.5 then
        baseColor
    else
        max ((toFloat baseColor) + (star.warmth * (toFloat 50))) (toFloat 255) |> floor


redStarColor : Star -> Int -> Int
redStarColor star baseColor =
    if star.warmth > 0.5 then
        baseColor
    else
        max ((toFloat baseColor) + ((star.warmth * 2) * (toFloat 255))) (toFloat 255) |> floor
