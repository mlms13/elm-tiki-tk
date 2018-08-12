module Tiki.Style.Internal.Common exposing
  ( MakeElement
  , applyStyles
  )

import Element exposing (Attribute, Element)

type alias MakeElement msg el =
  List (Attribute msg) -> el -> Element msg

-- given a list of style rules and a "make element" function, return a
-- MakeElement function with the provided style rules appended.
applyStyles : List (Attribute msg) -> MakeElement msg el -> MakeElement msg el
applyStyles styles makeEl =
  makeEl << (List.append styles)


