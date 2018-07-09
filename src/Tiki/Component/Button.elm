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
import Tiki.Style.Internal.Button exposing (defaultConfig, generate)

{ builders, elements } =
  Cfg.default |> defaultConfig |> generate

-- { default, danger, warning, success, primary } = builders
{ btn, defaultBtn, dangerBtn, warningBtn, successBtn, primaryBtn } = elements
