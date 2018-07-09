module Tiki.Style.ComponentOverrides exposing
  ( ComponentOverrides
  , defaultFromConfig
  )

import Tiki.Style.Config exposing (Config)
import Tiki.Style.Internal.Button as Button

type alias ComponentOverrides =
  { button : Button.ButtonConfig
  -- TODO:
  -- , nav : NavStyle
  -- , dropdown: DropdownStyle
  -- , modal , toast , label, notification etc
  }

defaultFromConfig : Config -> ComponentOverrides
defaultFromConfig cfg =
  { button = Button.defaultConfig cfg
  }
