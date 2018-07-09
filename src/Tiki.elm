module Tiki exposing
  ( Styles
  , generate
  )

import Tiki.Style.ComponentOverrides exposing (ComponentOverrides, defaultFromConfig)
import Tiki.Style.Config exposing (Config)
import Tiki.Style.Internal.Button as GenButton

type alias Styles msg el =
  { button : GenButton.ButtonStyle msg el
  }

generateFromOverrides : ComponentOverrides -> Styles msg el
generateFromOverrides v =
  { button = GenButton.generate v.button
  }

generate : Config -> Styles msg el
generate =
  generateFromOverrides << defaultFromConfig

  -- let
  --   borderAttr : ColorPair -> BorderConfig -> List (Attribute msg)
  --   borderAttr { bg, fg } border =
  --     let
  --       make w c =
  --         [ Border.width w
  --         , Border.solid
  --         , Border.color c
  --         ]

  --     in
  --     case border of
  --       None -> []
  --       Solid width (Custom c) ->
  --         make width c
  --       Solid width Foreground ->
  --         make width fg
  --       Solid width Background ->
  --         make width (extractBgColor bg)

  --   makeBtnVariant : ColorPair -> List (Attribute msg)
  --   makeBtnVariant { bg, fg } =
  --     [bgColorToAttr bg] ++

  --     [ ]

  --   btn =
  --     , Font.center
  --     -- , font weight (Font.bold vs Font.semibold, etc)
  --     -- , line-height
  --     , paddingEach size.normal.padding
  --     -- , user-select none
  --     -- , white-space nowrap
  --     ] ++ (makeBtnVariant color.default)

  --   danger =
  --     makeBtnVariant color.danger

  --   warning =
  --     makeBtnVariant color.warning

  --   success =
  --     makeBtnVariant color.success

  --   primary =
  --     makeBtnVariant color.primary
  -- in
  -- { danger = makeStyles danger
  -- , warning = makeStyles warning
  -- , success = makeStyles success
  -- , primary = makeStyles primary
  -- , btn = makeStyles btn
  -- }

