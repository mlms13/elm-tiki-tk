module Tiki.Style.Config exposing (..)

import Color exposing (Color, rgb, rgba)
import Element.Font exposing (Font, typeface, sansSerif, serif, monospace)

type alias Sides =
  { top : Int, right : Int, bottom : Int, left : Int}

type alias BoxShadow =
  { offset : (Float, Float)
  , blur : Float
  , size : Float
  , color : Color
  }

type alias ColorConfig =
  -- TODO: maybe each of these should be a pair of colors, one for bg, one for
  -- text. Then we could do away with fg/fginverse
  { primary : Color
  , info : Color
  , success : Color
  , warning : Color
  , danger : Color
  , default : Color

  -- TODO: consider splitting colors into color.normal.danger vs
  -- color.inverse.danger, where one can be used for light bg, vs dark
  , fg : Color -- text color, default to black for light bg
  , fgInverse : Color -- light color text on dark bg
  }

type alias DecorationConfig =
  { borderWidth : Int
  , borderRadius : Int
  , boxShadow : BoxShadow
  , boxShadowInset : BoxShadow
  }

type alias SizeConfig =
  { padding : Sides
  }

type alias FontConfig =
  { family : List Font
  , size : Int
  , lineHeight : Float
  }

-- type alias ButtonStyle =
--   { borderWidth : Int
--   , borderRadius : Int
--   }

type alias Config =
  { color : ColorConfig
  , size :
    { small : SizeConfig
    , normal : SizeConfig
    , large : SizeConfig
    } -- TODO: mini, massive, all of them
  , font :
    { sans : FontConfig
    , serif : FontConfig
    , mono : FontConfig
    , base : FontConfig
    }
  , link : {}
  , heading : {}
  , decoration : DecorationConfig -- border-radius, etc

  -- TODO: do we want to allow overriding things like color and decoration on a
  -- per-component basis? Will this make initial setup much more confusing?
  -- , button : ButtonStyle
  -- , nav : NavStyle
  -- , dropdown: DropdownStyle
  -- , modal , toast , label , etc
  }

defaultColor : ColorConfig
defaultColor =
  { primary = rgb 0x26 0x93 0xb3
  , info = rgb 0x26 0x93 0xb3
  , success = rgb 0x28 0xbd 0x35
  , warning = rgb 0xe6 0x95 0x29
  , danger = rgb 0xda 0x32 0x29
  , default = rgb 0xee 0xee 0xee
  , fg = rgb 0x22 0x22 0x22 -- text color, default to black for light bg
  , fgInverse = rgb 0xff 0xff 0xff -- light color text on dark bg
  }

multiplySides : Sides -> Float -> Sides
multiplySides { top, right, bottom, left } mult =
  Sides (round ((toFloat top) * mult)) (round ((toFloat right) * mult)) (round ((toFloat bottom) * mult)) (round ((toFloat left) * mult))


defaultSizeNormal : SizeConfig
defaultSizeNormal =
  -- { spacing = { top : 0, left : 0, bottom : 0, right : 0 }
  { padding = { top = 8, left = 16, bottom = 8, right = 16 }
  }

defaultSizeSmall : SizeConfig
defaultSizeSmall =
  SizeConfig <| multiplySides defaultSizeNormal.padding 0.9

defaultSizeLarge : SizeConfig
defaultSizeLarge =
  SizeConfig <| multiplySides defaultSizeNormal.padding 1.2

defaultFontSans : FontConfig
defaultFontSans =
  FontConfig
    [ typeface "-apple-system"
    , typeface "BlinkMacSystemFont"
    , typeface "Segoe UI"
    , typeface "Roboto"
    , typeface "Oxygen"
    , typeface "Ubuntu"
    , typeface "Cantarell"
    , typeface "Fira Sans"
    , typeface "Droid Sans"
    , typeface "Helvetica Neue"
    , typeface "Arial"
    , sansSerif
    ]
    16
    1.4

defaultFontSerif : FontConfig
defaultFontSerif =
  FontConfig
    [ typeface "Georgia"
    , typeface "Times New Roman"
    , typeface "Times"
    , serif
    ]
    16
    1.4

defaultFontMono : FontConfig
defaultFontMono =
  FontConfig
    [ typeface "Menlo"
    , typeface "Monaco"
    , typeface "Consolas"
    , typeface "Liberation Mono"
    , typeface "Courier New"
    , monospace
    ]
    16
    1.4

defaultFontBase : FontConfig
defaultFontBase = defaultFontSans

defaultDecoration : DecorationConfig
defaultDecoration =
  { borderWidth = 1
  , borderRadius = 3
  , boxShadow = BoxShadow (1.0, 1.0) 0.0 0.0 (rgba 0 0 0 0.15)
  , boxShadowInset = BoxShadow (0.0, 1.0) 2.0 0.0 (rgba 0 0 0 0.2)
  }

default : Config
default =
  { color = defaultColor
  , size =
    { small = defaultSizeSmall
    , normal = defaultSizeNormal
    , large = defaultSizeLarge
    } -- TODO: mini, massive, all of them
  , font =
    { sans = defaultFontSans
    , serif = defaultFontSerif
    , mono = defaultFontMono
    , base = defaultFontBase
    }
  , link = {}
  , heading = {}
  , decoration = defaultDecoration
  -- , button = defaultButtonStyle
  -- TODO? nav-specific
  -- TODO? dropdown-specific
  -- TODO? modals, toast, notification, etc
  }
