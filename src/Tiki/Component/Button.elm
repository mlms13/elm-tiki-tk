module Tiki.Component.Button exposing
  ( btn
  , dangerBtn
  , warningBtn
  , successBtn
  , primaryBtn
  )

import Element.Input exposing (button)
import Tiki exposing (Styles, generate)
import Tiki.Style.Config exposing (default)

-- TODO: figure out a useful place for this to live
generateElements styles =
  let
    btn = styles.btn
  in
  { btn = button |> btn
  , dangerBtn = button |> btn |> styles.danger
  , warningBtn = button |> btn |> styles.warning
  , successBtn = button |> btn |> styles.success
  , primaryBtn = button |> btn |> styles.primary
  }

{ btn, dangerBtn, warningBtn, successBtn, primaryBtn } =
  generateElements <| generate default
