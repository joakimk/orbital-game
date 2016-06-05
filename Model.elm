module Model exposing (..)

import Window

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
