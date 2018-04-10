module Tiki.Style.Config exposing (..)

import Color exposing (Color, rgb, rgba)
import Element.Font exposing (Font, typeface, sansSerif, serif, monospace)
import List.Nonempty exposing (Nonempty)

type alias Sides =
  { top : Int, right : Int, bottom : Int, left : Int}

type alias BoxShadow =
  { offset : (Float, Float)
  , blur : Float
  , size : Float
  , color : Color
  }

type BackgroundColor
  = Fill Color
  | LinearGradient Float (Nonempty Color)

type alias ColorPair =
  { bg : BackgroundColor
  , fg : Color
  }

type alias ColorConfig =
  { primary : ColorPair
  , info : ColorPair
  , success : ColorPair
  , warning : ColorPair
  , danger : ColorPair
  , default : ColorPair
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
  , boxShadow : BoxShadow
  -- , boxShadowInset : BoxShadow
  , border : BorderConfig
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
  { primary = ColorPair (Fill <| rgb 0x26 0x93 0xb3) (rgb 0xff 0xff 0xff)
  , info = ColorPair (Fill <| rgb 0x26 0x93 0xb3) (rgb 0xff 0xff 0xff)
  , success = ColorPair (Fill <| rgb 0x28 0xbd 0x35) (rgb 0xff 0xff 0xff)
  , warning = ColorPair (Fill <| rgb 0xe6 0x95 0x29) (rgb 0xff 0xff 0xff)
  , danger = ColorPair (Fill <| rgb 0xda 0x32 0x29) (rgb 0xff 0xff 0xff)
  , default = ColorPair (Fill <| rgb 0xee 0xee 0xee) (rgb 0x22 0x22 0x22)
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
  { borderRadius = 3
  , boxShadow = BoxShadow (1.0, 1.0) 0.0 0.0 (rgba 0 0 0 0.15)
  -- , boxShadowInset = BoxShadow (0.0, 1.0) 2.0 0.0 (rgba 0 0 0 0.2)
  , border = None
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
