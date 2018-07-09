module Tiki.Style.Config.BackgroundColor exposing
  ( BackgroundColor(..)
  , extractColor
  , darkenBg
  , toAttr
  )

import Color exposing (Color)
import Color.Manipulate exposing (darken)
import Element exposing (Attr)
import Element.Background as BG
import List.Nonempty exposing (Nonempty(..), toList, map)

type BackgroundColor
  = Fill Color
  | LinearGradient Float (Nonempty Color)

-- TODO: i'm not completely convinced this is useful
-- for borders... we should make them specify a color
extractColor : BackgroundColor -> Color
extractColor bg =
  case bg of
    Fill c -> c
    LinearGradient _ (Nonempty c _) -> c

darkenBg : Float -> BackgroundColor -> BackgroundColor
darkenBg amt bg =
  case bg of
    Fill c ->
      Fill <| darken amt c

    LinearGradient dir colors ->
      LinearGradient dir <| map (darken amt) colors


toAttr : BackgroundColor -> Attr d msg
toAttr bg =
  case bg of
    Fill c -> BG.color c
    LinearGradient dir colors -> BG.gradient dir (toList colors)
