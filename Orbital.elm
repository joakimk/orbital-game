import Color exposing (grayscale)
import Element exposing (toHtml)
import Collage exposing (collage, rect, filled)
import Html.App
import Html exposing (Html)
import Time exposing (Time, inSeconds)
import Keyboard
import Task
import Window

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
  case msg of
    WindowResize size ->
      ({ game | window = size }, Cmd.none)
    _ ->
      (game, Cmd.none)

-- MODEL

initialGame : Game
initialGame =
  { map = {
      planets = []
    }
  , window = { width = 0, height = 0 }
  }

type alias Game =
  { map : Map
  , window : Window.Size
  }

type alias Map =
  { planets : List Planet
  }

type alias Planet =
  { x : Int
  , y : Int
  }

-- GLUE

type Msg = Keypress Keyboard.KeyCode
         --| TimeUpdate Float
         | WindowResize Window.Size

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
  ]
  |> Cmd.batch

subscriptions : a -> Sub Msg
subscriptions _ =
  [ (Keyboard.presses Keypress)
  --, (Time.every (Time.millisecond * 250) TimeUpdate)
  , (Window.resizes WindowResize)
  ]
  |> Sub.batch
