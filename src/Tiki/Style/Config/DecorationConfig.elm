module Tiki.Style.Config.DecorationConfig exposing
  ( DecorationConfig
  , ShadowConfig
  , default
  )

import Color exposing (Color, rgba)

type alias ShadowConfig =
  { offset : (Float, Float)
  , blur : Float
  , size : Float
  , color : Color
  }

type BorderColor
  = Custom Color
  | Background
  | Foreground

type BorderConfig
  = None
  | Solid Int BorderColor

type alias DecorationConfig =
  { borderRadius : Int
  , shadow : ShadowConfig
  -- , boxShadowInset : BoxShadow
  , border : BorderConfig
  }

default : DecorationConfig
default =
  { borderRadius = 3
  , shadow = ShadowConfig (1.0, 1.0) 0.0 0.0 (rgba 0 0 0 0.15)
  -- , boxShadowInset = BoxShadow (0.0, 1.0) 2.0 0.0 (rgba 0 0 0 0.2)
  , border = None
  }
