module Tiki.Style.Config.ColorConfig exposing
  ( ColorConfig
  , ColorPair
  , default
  )

import Color exposing (Color, rgb)
import Tiki.Style.Config.BackgroundColor exposing (BackgroundColor(..))

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

default : ColorConfig
default =
  { primary = ColorPair (Fill <| rgb 0x26 0x93 0xb3) (rgb 0xff 0xff 0xff)
  , info = ColorPair (Fill <| rgb 0x26 0x93 0xb3) (rgb 0xff 0xff 0xff)
  , success = ColorPair (Fill <| rgb 0x28 0xbd 0x35) (rgb 0xff 0xff 0xff)
  , warning = ColorPair (Fill <| rgb 0xe6 0x95 0x29) (rgb 0xff 0xff 0xff)
  , danger = ColorPair (Fill <| rgb 0xda 0x32 0x29) (rgb 0xff 0xff 0xff)
  , default = ColorPair (Fill <| rgb 0xee 0xee 0xee) (rgb 0x22 0x22 0x22)
  }
