import Element exposing (..)
import Element.Input exposing (button)
import Html exposing (Html)
import Tiki.Config exposing (default)
import Tiki.Styles exposing (generate)

{ btn } = generate default

main : Html msg
main =
  Element.layout [] <|
    (button |> btn) [] { onPress = Nothing, label = (text "Hi") }
