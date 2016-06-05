import Color exposing (rgb, grayscale)
import Element exposing (toHtml)
import Collage exposing (collage, rect, oval, move, filled, group)
import Html.App
import Html exposing (Html)
import Time exposing (Time, inSeconds)
import Keyboard
import Task
import Window
import Random

view : Game -> Html Msg
view game =
  collage game.window.width game.window.height [
    drawBackground game
  , drawStars game
  ]
  |> toHtml

drawBackground game =
  rect (toFloat game.window.width) (toFloat game.window.height)
  |> filled (grayscale 1)

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

moveTopLeft game (x, y) form =
  let
    windowX = x - (toFloat game.window.width) / 2
    windowY = y - (toFloat game.window.height) / 2
  in
    form
    |> move (windowX, -windowY)

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

-- MODEL

initialGame : Game
initialGame =
  { planets = []
  , stars = []
  , window = { width = 0, height = 0 }
  }

type alias Game =
  { planets : List Planet
  , stars : List Star
  , window : Window.Size
  }

type alias Star =
  { x : Float
  , y : Float
  , size : Float
  , luminosity : Float
  , warmth : Float
  }

type alias Planet =
  { x : Int
  , y : Int
  }

-- GLUE

type Msg = Keypress Keyboard.KeyCode
         --| TimeUpdate Float
         | WindowResize Window.Size
         | RandomStarData (List ((Float, Float), (Float, Float, Float)))

main : Program Never
main =
  Html.App.program
  { view = view
  , update = update
  , init = (initialGame, initialCommand)
  , subscriptions = subscriptions
  }

initialCommand =
  [ (Task.perform WindowResize WindowResize (Window.size))
  , (Random.generate RandomStarData randomIntPairs)
  ]
  |> Cmd.batch

randomIntPairs : Random.Generator (List ((Float, Float), (Float, Float, Float)))
randomIntPairs =
  Random.list 300 <|
    Random.pair
      (Random.pair (Random.float 0 100) (Random.float 0 100))
      (Random.map3 (,,) (Random.float 1 3) (Random.float 0.5 1) (Random.float 0.1 1))

subscriptions : a -> Sub Msg
subscriptions _ =
  [ (Keyboard.presses Keypress)
  --, (Time.every (Time.millisecond * 250) TimeUpdate)
  , (Window.resizes WindowResize)
  ]
  |> Sub.batch
