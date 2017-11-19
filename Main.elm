module Main exposing (..)

import Html
import Time exposing (Time, inSeconds)
import Task
import Random
import Keyboard
import Window
import AnimationFrame
import View exposing (view)
import Update exposing (..)
import Model exposing (..)


-- GLUE


main : Program Never Game Msg
main =
    Html.program
        { view = view
        , update = update
        , init = ( initialGame, initialCommand )
        , subscriptions = subscriptions
        }


initialCommand : Cmd Msg
initialCommand =
    [ (Task.perform WindowResize (Window.size))
    , (Random.generate NewRandomStarData randomIntPairs)
    ]
        |> Cmd.batch


randomIntPairs : Random.Generator (List ( ( Float, Float ), ( Float, Float, Float ) ))
randomIntPairs =
    Random.list 300 <|
        Random.pair
            (Random.pair (Random.float 0 100) (Random.float 0 100))
            (Random.map3 (,,) (Random.float 1 3) (Random.float 0.5 1) (Random.float 0.1 1))


subscriptions : a -> Sub Msg
subscriptions _ =
    [ (Keyboard.presses Keypress)
    , (AnimationFrame.diffs TimeDiffSinceLastFrame)
    , (Time.every (Time.millisecond * 400) TwinkleStar)
    , (Window.resizes WindowResize)
    ]
        |> Sub.batch


fps : Int
fps =
    60
