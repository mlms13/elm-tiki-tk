module Tiki.Style.Internal.Button exposing
  ( StyleConfig
  , ButtonElements
  , config
  , generate
  )

import Element exposing (Attribute, Element, focused, mouseOver, mouseDown, paddingEach)
import Element.Border as Border
import Element.Font exposing (center)
import Element.Input as ElInpt
import Tiki.Style.Config exposing (Config)
import Tiki.Style.Config.ColorConfig exposing (ColorConfig, ColorPair, bgToAttr, fgToAttr)
import Tiki.Style.Config.DecorationConfig exposing (ShadowConfig)
import Tiki.Style.Config.SizeConfig exposing (AllSizeConfig)
import Tiki.Style.Internal.Common exposing (MakeElement, applyStyles)

type alias StyleConfig =
  { borderRadius : Int
  , shadow : ShadowConfig
  , color : ColorConfig
  , size : AllSizeConfig
  }

type alias ButtonProps msg =
  { label : Element msg
  , onPress : Maybe msg
  }

type alias MakeButton msg =
  MakeElement msg (ButtonProps msg)

-- "builders" take any element and apply button styling to it while "elements"
-- are specifically functions that produce Style Element buttons
type alias ButtonElements msg el =
  { builders :
    { danger : MakeElement msg el -> MakeElement msg el
    , warning : MakeElement msg el -> MakeElement msg el
    , success : MakeElement msg el -> MakeElement msg el
    , primary : MakeElement msg el -> MakeElement msg el
    , default : MakeElement msg el -> MakeElement msg el
    }
  , elements :
    { btn : MakeButton msg
    , defaultBtn : MakeButton msg
    , dangerBtn : MakeButton msg
    , warningBtn : MakeButton msg
    , successBtn : MakeButton msg
    , primaryBtn : MakeButton msg
    }
  }

config : Config -> StyleConfig
config { decoration, color, size } =
  { borderRadius = decoration.borderRadius
  , shadow = decoration.shadow
  , color = color
  , size = size
  }

makeVariant : ColorPair -> List (Attribute msg)
makeVariant { bg, fg } =
  [bgToAttr bg] ++

  -- borderAttr (ColorPair bg fg) decoration.border ++
  [ fgToAttr fg
  -- , mouseOver <|
  --   [ BgColor.toAttr <| BgColor.darkenBg 0.06 bg
  --   ]
  -- , focused <|
  --   [ BgColor.toAttr <| BgColor.darkenBg 0.06 bg
  --   , Border.shadow <| ShadowConfig (0.0, 0.0) 0.0 3.0 (fadeOut 0.5 (BgColor.extractColor bg))
  --   ]
  , mouseDown <|
    [ -- TODO: btn active box shadow
    ]
  ]

generate : StyleConfig -> ButtonElements msg el
generate { borderRadius, shadow, color, size } =
  let
    btnStyle =
      [ Border.rounded borderRadius
      , Border.shadow shadow
      , center
      , paddingEach size.normal.padding
      ]

    builders =
      { danger = applyStyles <| makeVariant color.danger
      , warning = applyStyles <| makeVariant color.warning
      , success = applyStyles <| makeVariant color.success
      , primary = applyStyles <| makeVariant color.primary
      , default = applyStyles <| makeVariant color.default
      }

    btn = applyStyles btnStyle ElInpt.button

    elements =
      { btn = btn
      , defaultBtn = builders.default btn
      , dangerBtn = builders.danger btn
      , warningBtn = builders.warning btn
      , successBtn = builders.success btn
      , primaryBtn = builders.primary btn
      }
  in
    ButtonElements builders elements
