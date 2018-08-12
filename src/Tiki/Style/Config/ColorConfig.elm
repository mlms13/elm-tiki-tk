module Tiki.Style.Config.ColorConfig exposing
  ( ColorConfig
  , ColorPair
  , default
  , bgToAttr
  , fgToAttr
  )

import Color exposing (Color, rgb)
import Element exposing (Attribute)
import Element.Background as ElBG
import Element.Font as ElFont
import List.Nonempty exposing (Nonempty, toList)

type BackgroundColor
  = Solid Color
  | VerticalGradiant (Nonempty Color)

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
  { primary = ColorPair (Solid <| rgb 0x26 0x93 0xb3) (rgb 0xff 0xff 0xff)
  , info = ColorPair (Solid <| rgb 0x26 0x93 0xb3) (rgb 0xff 0xff 0xff)
  , success = ColorPair (Solid <| rgb 0x28 0xbd 0x35) (rgb 0xff 0xff 0xff)
  , warning = ColorPair (Solid <| rgb 0xe6 0x95 0x29) (rgb 0xff 0xff 0xff)
  , danger = ColorPair (Solid <| rgb 0xda 0x32 0x29) (rgb 0xff 0xff 0xff)
  , default = ColorPair (Solid <| rgb 0xee 0xee 0xee) (rgb 0x22 0x22 0x22)
  }

fgToAttr : Color -> Attribute msg
fgToAttr =
  ElFont.color

bgToAttr : BackgroundColor -> Attribute msg
bgToAttr bg =
  case bg of
    Solid c ->
      ElBG.color c

    VerticalGradiant colors ->
      ElBG.gradient (pi / 2.0) (toList colors)