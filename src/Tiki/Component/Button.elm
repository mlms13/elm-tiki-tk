module Tiki.Component.Button exposing
  ( btn
  , dangerBtn
  , warningBtn
  , successBtn
  , primaryBtn
  )

import Element exposing (Attribute, Element)
import Element.Input exposing (button)
import Tiki exposing (Styles, generate)
import Tiki.Style.Config exposing (default)

styles : Styles msg el
styles = generate default

btn :
  List (Attribute msg)
  ->
    { onPress : Maybe msg
    , label : Element msg
    }
  -> Element msg
btn = button |> styles.btn

dangerBtn :
  List (Attribute msg)
  ->
    { onPress : Maybe msg
    , label : Element msg
    }
  -> Element msg
dangerBtn = btn |> styles.danger

warningBtn :
  List (Attribute msg)
  ->
    { onPress : Maybe msg
    , label : Element msg
    }
  -> Element msg
warningBtn = btn |> styles.warning

successBtn :
  List (Attribute msg)
  ->
    { onPress : Maybe msg
    , label : Element msg
    }
  -> Element msg
successBtn = btn |> styles.success

primaryBtn :
  List (Attribute msg)
  ->
    { onPress : Maybe msg
    , label : Element msg
    }
  -> Element msg
primaryBtn = btn |> styles.primary
