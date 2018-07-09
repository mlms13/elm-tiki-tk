module Tiki.Style.Config exposing (..)

import Element.Font exposing (Font, typeface, sansSerif, serif, monospace)
import Tiki.Style.Config.ColorConfig as ColorCfg
import Tiki.Style.Config.DecorationConfig as Decoration
import Tiki.Style.Config.SizeConfig as SizeCfg

type alias FontConfig =
  { family : List Font
  , size : Int
  , lineHeight : Float
  }

type alias Config =
  { color : ColorCfg.ColorConfig
  , size : SizeCfg.AllSizeConfig
  , font :
    { sans : FontConfig
    , serif : FontConfig
    , mono : FontConfig
    , base : FontConfig
    }
  , link : {}
  , heading : {}
  , decoration : Decoration.DecorationConfig -- border-radius, etc
  }

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

default : Config
default =
  { color = ColorCfg.default
  , size = SizeCfg.default
  , font =
    { sans = defaultFontSans
    , serif = defaultFontSerif
    , mono = defaultFontMono
    , base = defaultFontBase
    }
  , link = {}
  , heading = {}
  , decoration = Decoration.default
  }
