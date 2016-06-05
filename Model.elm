module Model exposing (..)

import Window

initialGame : Game
initialGame =
  { planets = [
      { x = 0, y = 0, size = 400, gravity = 10, texture = "planet_18" }
    , { x = 300, y = 0, size = 100, gravity = 5, texture = "planet_20" }
    , { x = 300, y = 80, size = 20, gravity = 2, texture = "planet_20" }
    ]
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
  { x : Float
  , y : Float
  , size : Float
  , gravity : Float
  , texture : String
  }
