module Tiki.Component.Button exposing
  ( builders
  , elements
  , btn
  , defaultBtn
  , dangerBtn
  , warningBtn
  , successBtn
  , primaryBtn
  )

-- import Tiki exposing (Styles)
import Tiki.Style.Config as Cfg
import Tiki.Style.Internal.Button exposing (config, generate)

{ builders, elements } =
  Cfg.default |> config |> generate

-- { default, danger, warning, success, primary } = builders
{ btn, defaultBtn, dangerBtn, warningBtn, successBtn, primaryBtn } = elements
