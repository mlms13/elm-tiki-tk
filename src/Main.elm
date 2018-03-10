import Element exposing (..)
import Element.Input exposing (button)
import Html exposing (Html)
import Tiki.Config exposing (default)
import Tiki.Styles as Styles

{ btn, danger, warning, primary, success } = Styles.generate default

main : Html msg
main =
  Element.layout [ ] <|
    row [ alignTop, padding 20, spacing 5 ]
      [ (button |> btn |> danger) [ spacing 5 ] { onPress = Nothing, label = (text "Danger") }
      , (button |> btn |> warning) [ spacing 5 ] { onPress = Nothing, label = (text "Warning") }
      , (button |> btn |> success) [ spacing 5 ] { onPress = Nothing, label = (text "Success") }
      , (button |> btn |> primary) [ spacing 5 ] { onPress = Nothing, label = (text "Primary") }
      ]

