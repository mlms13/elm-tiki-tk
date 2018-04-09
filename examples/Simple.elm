import Element exposing (..)
import Html exposing (Html)
import Tiki.Component.Button exposing (..)

main : Html msg
main =
  Element.layout [] <|
    row [ alignTop, padding 20, spacing 5 ]
      [ dangerBtn [] { onPress = Nothing, label = (text "Danger") }
      , warningBtn [] { onPress = Nothing, label = (text "Warning") }
      , successBtn [] { onPress = Nothing, label = (text "Success") }
      , primaryBtn [] { onPress = Nothing, label = (text "Primary") }
      , btn [] { onPress = Nothing, label = (text "Default") }
      ]
