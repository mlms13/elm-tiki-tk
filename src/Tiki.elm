module Tiki exposing
  ( Styles
  , generate
  )

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Tiki.Style.Config exposing (Config)

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
    btn =
      [ Border.width decoration.borderWidth
      , Border.solid
      , Border.rounded decoration.borderRadius
      , Border.shadow decoration.boxShadow
      -- , font weight (Font.bold vs Font.semibold, etc)
      -- , line-height
      , paddingEach size.normal.padding
      , Font.center
      -- , user-select none
      -- , white-space nowrap
      ]

    danger =
      [ Background.color color.danger
      , Border.color color.danger
      , Font.color color.fgInverse
      ]

    warning =
      [ Background.color color.warning
      , Border.color color.warning
      , Font.color color.fgInverse
      ]

    success =
      [ Background.color color.success
      , Border.color color.success
      , Font.color color.fgInverse
      ]

    primary =
      [ Background.color color.primary
      , Border.color color.primary
      , Font.color color.fgInverse
      ]
  in
  { danger = makeStyles danger
  , warning = makeStyles warning
  , success = makeStyles success
  , primary = makeStyles primary
  , btn = makeStyles btn
  }

-- TODO
-- generateWithComponentOverrides : Config -> ComponentOverrides -> Styles msg el
