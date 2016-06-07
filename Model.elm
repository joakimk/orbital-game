module Model exposing (..)

import Window

initialGame : Game
initialGame =
  { planets = [
      { x = 0,    y = 0,    size = 300, vx = 0,    vy = 0,     gravity = 0.5,    texture = "planet_18", rotation = 0, textureRotation = -1.2 }
    , { x = 350,  y = -70,  size = 100, vx = -20,  vy = -100,  gravity = 0.25,   texture = "planet_20", rotation = 0, textureRotation = 0.6 }
    , { x = 350,  y = -170, size = 20,  vx = -150, vy = -90,   gravity = 0.005,  texture = "planet_20", rotation = 0, textureRotation = 0.6 }
    , { x = -350, y = -180, size = 10,  vx = 25,   vy = -50,   gravity = 0.0001, texture = "planet_28", rotation = 0, textureRotation = -1.2 }
    , { x = -320, y = -180, size = 10,  vx = 25,   vy = -50,   gravity = 0.0001, texture = "planet_28", rotation = 0, textureRotation = -1.2 }
    , { x = -300, y = -180, size = 10,  vx = 25,   vy = -50,   gravity = 0.0001, texture = "planet_30", rotation = 0, textureRotation = 3.1 }
    --, { x = -800,  y = -550,  size = 50, vx = 25,  vy = 50,    gravity = 0.2,    texture = "planet_24", rotation = 0, textureRotation = -1 }
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
  , startLuminosity : Float
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
  , textureRotation : Float
  , rotation : Float
  }
