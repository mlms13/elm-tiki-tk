module Tiki exposing
  ( Styles
  , generate
  )

import Color exposing (Color)
import Color.Manipulate exposing (darken, fadeOut)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import List.Nonempty exposing (Nonempty(..), toList)
import Tiki.Style.Config exposing (Config, BoxShadow, ColorPair, BackgroundColor(..), BorderColor(..), BorderConfig(..))

type alias MkElement msg el =
  List (Attribute msg) -> el -> Element msg

-- TODO: pretty sure `el` doesn't belong in Styles
-- each style should be specific to one type of `el`
type alias Styles msg el =
  { danger : MkElement msg el -> MkElement msg el
  , warning : MkElement msg el -> MkElement msg el
  , success : MkElement msg el -> MkElement msg el
  , primary : MkElement msg el -> MkElement msg el
  , btn : MkElement msg el -> MkElement msg el
  }

-- given a list of style rules and a "make element" function, return a MkElement
-- function with the provided style rules prepended.
makeStyles : List (Attribute msg) -> MkElement msg el -> MkElement msg el
makeStyles styles makeEl =
  makeEl << (List.append styles)

generate : Config -> Styles msg el
generate { color, size, font, decoration} =
  let
    bgColorToAttr : BackgroundColor -> Attribute msg
    bgColorToAttr bg =
      case bg of
        Fill c -> Background.color c
        LinearGradient dir colors -> Background.gradient dir (toList colors)

    extractBgColor : BackgroundColor -> Color
    extractBgColor bg =
      case bg of
        Fill c -> c
        LinearGradient _ (Nonempty c _) -> c


    borderAttr : ColorPair -> BorderConfig -> List (Attribute msg)
    borderAttr { bg, fg } border =
      let
        make w c =
          [ Border.width w
          , Border.solid
          , Border.color c
          ]

      in
      case border of
        None -> []
        Solid width (Custom c) ->
          make width c
        Solid width Foreground ->
          make width fg
        Solid width Background ->
          make width (extractBgColor bg)

    makeBtnVariant : ColorPair -> List (Attribute msg)
    makeBtnVariant { bg, fg } =
      [bgColorToAttr bg] ++
      borderAttr (ColorPair bg fg) decoration.border ++
      [ Font.color fg
      , mouseOver <|
        [ Background.color <| darken 0.06 (extractBgColor bg)
        , Border.color <| darken 0.06 (extractBgColor bg)
        ]
      , focused <|
        [ Background.color <| darken 0.06 (extractBgColor bg)
        , Border.color <| darken 0.06 (extractBgColor bg)
        , Border.shadow <| BoxShadow (0.0, 0.0) 0.0 3.0 (fadeOut 0.5 (extractBgColor bg))
        ]
      , mouseDown <|
        [ Border.color <| darken 0.1 (extractBgColor bg)
        -- , TODO: btn active box shadow
        ]
      ]

    btn =
      [ Border.rounded decoration.borderRadius
      , Border.shadow decoration.boxShadow
      , Font.center
      -- , font weight (Font.bold vs Font.semibold, etc)
      -- , line-height
      , paddingEach size.normal.padding
      -- , user-select none
      -- , white-space nowrap
      ] ++ (makeBtnVariant color.default)

    danger =
      makeBtnVariant color.danger

    warning =
      makeBtnVariant color.warning

    success =
      makeBtnVariant color.success

    primary =
      makeBtnVariant color.primary
  in
  { danger = makeStyles danger
  , warning = makeStyles warning
  , success = makeStyles success
  , primary = makeStyles primary
  , btn = makeStyles btn
  }

-- TODO
-- generateWithComponentOverrides : Config -> ComponentOverrides -> Styles msg el
