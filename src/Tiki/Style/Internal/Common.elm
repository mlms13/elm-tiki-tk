module Tiki.Style.Internal.Common exposing
  ( MkElement
  , applyStyles
  )

import Element exposing (Attribute, Element)


type alias MkElement msg el =
  List (Attribute msg) -> el -> Element msg


-- given a list of style rules and a "make element" function, return a MkElement
-- function with the provided style rules prepended.
applyStyles : List (Attribute msg) -> MkElement msg el -> MkElement msg el
applyStyles styles makeEl =
  makeEl << (List.append styles)


