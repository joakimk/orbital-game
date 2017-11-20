module View exposing (view)

import Collage exposing (Form, collage, filled, group, move, rect, rotate, toForm)
import Color exposing (grayscale)
import Element exposing (image, toHtml)
import Html exposing (Html)
import LazyForm exposing (lazyForm)
import Model exposing (Game, Planet)
import Star exposing (drawStars)
import Window exposing (Size)


view : Game -> Html msg
view game =
    collage game.window.width
        game.window.height
        [ lazyForm drawBackground game.window
        , lazyForm drawStars ( game.window, game.stars )

        -- planets change too much to lazyRender
        , drawPlanets game
        ]
        |> toHtml


drawBackground : Window.Size -> Form
drawBackground window =
    rect (toFloat window.width) (toFloat window.height)
        |> filled (grayscale 1)


drawPlanets : Game -> Form
drawPlanets game =
    List.map (lazyForm drawPlanet) game.planets
        |> group


drawPlanet : Planet -> Form
drawPlanet planet =
    let
        size =
            planet.size |> floor
    in
        image size size ("textures/" ++ planet.texture ++ ".png")
            |> toForm
            |> rotate (planet.textureRotation + planet.rotation)
            |> move ( planet.x, planet.y )
