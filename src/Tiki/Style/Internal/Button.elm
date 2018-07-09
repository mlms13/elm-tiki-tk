module Tiki.Style.Internal.Button exposing
  ( ButtonConfig
  , ButtonStyle
  , defaultConfig
  , generate
  )

import Color.Manipulate exposing (darken, fadeOut)
import Element exposing (Attribute, Element, focused, mouseOver, mouseDown, paddingEach)
import Element.Border as Border
import Element.Font as Font
import Element.Input as ElInpt
import Tiki.Style.Config exposing (Config)
import Tiki.Style.Config.BackgroundColor as BgColor
import Tiki.Style.Config.ColorConfig exposing (ColorConfig, ColorPair)
import Tiki.Style.Config.DecorationConfig exposing (BoxShadow)
import Tiki.Style.Config.SizeConfig exposing (AllSizeConfig)
import Tiki.Style.Internal.Common exposing (MkElement, applyStyles)

type alias ButtonConfig =
  { borderRadius : Int
  , boxShadow : BoxShadow
  , color : ColorConfig
  , size : AllSizeConfig
  }

type alias ButtonStyle msg el =
  { builders :
    { danger : MkElement msg el -> MkElement msg el
    , warning : MkElement msg el -> MkElement msg el
    , success : MkElement msg el -> MkElement msg el
    , primary : MkElement msg el -> MkElement msg el
    , default : MkElement msg el -> MkElement msg el
    }
  , elements :
    { btn : List (Attribute msg) -> { onPress : Maybe msg, label : Element msg } -> Element msg
    , defaultBtn : List (Attribute msg) -> { onPress : Maybe msg, label : Element msg } -> Element msg
    , dangerBtn : List (Attribute msg) -> { onPress : Maybe msg, label : Element msg } -> Element msg
    , warningBtn : List (Attribute msg) -> { onPress : Maybe msg, label : Element msg } -> Element msg
    , successBtn : List (Attribute msg) -> { onPress : Maybe msg, label : Element msg } -> Element msg
    , primaryBtn : List (Attribute msg) -> { onPress : Maybe msg, label : Element msg } -> Element msg
    }
  }

defaultConfig : Config -> ButtonConfig
defaultConfig cfg =
  { borderRadius = cfg.decoration.borderRadius
  , boxShadow = cfg.decoration.boxShadow
  , color = cfg.color
  , size = cfg.size
  }

makeVariant : ColorPair -> List (Attribute msg)
makeVariant { bg, fg } =
  [BgColor.toAttr bg] ++

  -- borderAttr (ColorPair bg fg) decoration.border ++
  [ Font.color fg
  , mouseOver <|
    [ BgColor.toAttr <| BgColor.darkenBg 0.06 bg
    , Border.color <| darken 0.06 (BgColor.extractColor bg)
    ]
  , focused <|
    [ BgColor.toAttr <| BgColor.darkenBg 0.06 bg
    , Border.color <| darken 0.06 (BgColor.extractColor bg)
    , Border.shadow <| BoxShadow (0.0, 0.0) 0.0 3.0 (fadeOut 0.5 (BgColor.extractColor bg))
    ]
  , mouseDown <|
    [ Border.color <| darken 0.1 (BgColor.extractColor bg)
    -- , TODO: btn active box shadow
    ]
  ]

generate : ButtonConfig -> ButtonStyle msg el
generate cfg =
  let
    btnStyle =
      [ Border.rounded cfg.borderRadius
      , Border.shadow cfg.boxShadow
      , Font.center
      , paddingEach cfg.size.normal.padding
      ]
    builders =
      { danger = applyStyles <| makeVariant cfg.color.danger
      , warning = applyStyles <| makeVariant cfg.color.warning
      , success = applyStyles <| makeVariant cfg.color.success
      , primary = applyStyles <| makeVariant cfg.color.primary
      , default = applyStyles <| makeVariant cfg.color.default
      }
    btn = ElInpt.button |> (applyStyles btnStyle)
  in
    { builders = builders
    , elements =
      { btn = btn
      , defaultBtn = btn |> builders.default
      , dangerBtn = btn |> builders.danger
      , warningBtn = btn |> builders.warning
      , successBtn = btn |> builders.success
      , primaryBtn = btn |> builders.primary
      }
    }
