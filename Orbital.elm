import Color exposing (grayscale)
import Element exposing (toHtml)
import Collage exposing (collage, rect, filled)
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
  ]
  |> toHtml

drawBackground game =
  rect (toFloat game.window.width) (toFloat game.window.height)
  |> filled (grayscale 0.9)

update msg game =
  let
    x = Debug.log "Game" (toString game)
    y = Debug.log "Msg" (toString msg)
  in
    case msg of
      WindowResize size ->
        ({ game | window = size }, Cmd.none)
      RandomPositions positions ->
        (addStars game positions, Cmd.none)
      _ ->
        (game, Cmd.none)

addStars game positions =
  let
    stars = positions |> List.map buildStar
  in
    { game | stars = stars }

buildStar (x, y) =
  { x = x, y = y }

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
  { x : Int
  , y : Int
  }

type alias Planet =
  { x : Int
  , y : Int
  }

-- GLUE

type Msg = Keypress Keyboard.KeyCode
         --| TimeUpdate Float
         | WindowResize Window.Size
         | RandomPositions (List (Int, Int))

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
  , (Random.generate RandomPositions randomIntPairs)
  ]
  |> Cmd.batch

randomIntPairs : Random.Generator (List (Int, Int))
randomIntPairs =
  Random.list 10 <| Random.pair (Random.int 0 100) (Random.int 0 100)

subscriptions : a -> Sub Msg
subscriptions _ =
  [ (Keyboard.presses Keypress)
  --, (Time.every (Time.millisecond * 250) TimeUpdate)
  , (Window.resizes WindowResize)
  ]
  |> Sub.batch
