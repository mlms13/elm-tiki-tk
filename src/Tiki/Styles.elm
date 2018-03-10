module Tiki.Styles exposing (..)

import Element exposing (..)
import Element.Background as Background
import Tiki.Config exposing (Config)

type alias MkElement msg el =
  List (Attribute msg) -> el -> Element msg

type alias Styles msg el =
  { danger : MkElement msg el -> MkElement msg el
  , btn : MkElement msg el -> MkElement msg el
  }

generate : Config -> Styles msg el
generate { color, size, font } =
  { danger = (\mkElement -> \attrs child -> mkElement (Background.color color.danger :: attrs) child)
  , btn = (\mkElement -> \attrs child -> mkElement (Background.color color.default :: paddingEach size.normal.padding :: attrs) child)
  }
