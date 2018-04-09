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
import Tiki.Style.Config exposing (Config, BoxShadow)

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

    makeBtnVariant : Color -> Color -> List (Attribute msg)
    makeBtnVariant bg fg =
      [ Background.color bg
      , Border.color bg
      , Font.color fg
      , mouseOver <|
        [ Background.color <| darken 0.06 bg
        , Border.color <| darken 0.06 bg
        ]
      , focused <|
        [ Background.color <| darken 0.06 bg
        , Border.color <| darken 0.06 bg
        , Border.shadow <| BoxShadow (0.0, 0.0) 0.0 3.0 (fadeOut 0.5 bg)
        ]
      , mouseDown <|
        [ Border.color <| darken 0.1 bg
        -- , TODO: btn active box shadow
        ]
      ]

    btn =
      [ Border.width decoration.borderWidth
      , Border.solid
      , Border.rounded decoration.borderRadius
      , Border.shadow decoration.boxShadow
      , Font.center
      -- , font weight (Font.bold vs Font.semibold, etc)
      -- , line-height
      , paddingEach size.normal.padding
      -- , user-select none
      -- , white-space nowrap
      ] ++ (makeBtnVariant color.default color.fg)

    danger =
      makeBtnVariant color.danger color.fgInverse

    warning =
      makeBtnVariant color.warning color.fgInverse

    success =
      makeBtnVariant color.success color.fgInverse

    primary =
      makeBtnVariant color.primary color.fgInverse
  in
  { danger = makeStyles danger
  , warning = makeStyles warning
  , success = makeStyles success
  , primary = makeStyles primary
  , btn = makeStyles btn
  }

-- TODO
-- generateWithComponentOverrides : Config -> ComponentOverrides -> Styles msg el
