module Model exposing (..)

import Window

initialGame : Game
initialGame =
  { planets = [
      { x = 0, y = 0, size = 300, vx = 0, vy = 0, gravity = 1, texture = "planet_18" }
    , { x = 350, y = 0, size = 100, vx = 0, vy = -50, gravity = 0.2, texture = "planet_20" }
    , { x = 430, y = -30, size = 20, vx = -20, vy = -90, gravity = 0, texture = "planet_20" }
    , { x = -320, y = -150, size = 10, vx = 25, vy = -50, gravity = 0, texture = "planet_28" }
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
  , vx : Float
  , vy : Float
  , size : Float
  , gravity : Float
  , texture : String
  }
