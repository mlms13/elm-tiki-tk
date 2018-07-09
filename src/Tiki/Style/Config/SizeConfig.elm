module Tiki.Style.Config.SizeConfig exposing
  ( AllSizeConfig
  , SizeConfig
  , default
  )

type alias Sides =
  { top : Int
  , right : Int
  , bottom : Int
  , left : Int
  }

-- TODO: capture font size in here as well
type alias SizeConfig =
  { padding : Sides
  }

type alias AllSizeConfig =
  { small : SizeConfig
  , normal : SizeConfig
  , large : SizeConfig
  } -- TODO: mini, massive, all of them


-- TODO: have a function to generate all sizes from a base font size in px

multiplySides : Sides -> Float -> Sides
multiplySides { top, right, bottom, left } mult =
  Sides (round ((toFloat top) * mult)) (round ((toFloat right) * mult)) (round ((toFloat bottom) * mult)) (round ((toFloat left) * mult))


defaultSizeNormal : SizeConfig
defaultSizeNormal =
  -- { spacing = { top : 0, left : 0, bottom : 0, right : 0 }
  { padding = { top = 8, left = 16, bottom = 8, right = 16 }
  }

defaultSizeSmall : SizeConfig
defaultSizeSmall =
  SizeConfig <| multiplySides defaultSizeNormal.padding 0.9

defaultSizeLarge : SizeConfig
defaultSizeLarge =
  SizeConfig <| multiplySides defaultSizeNormal.padding 1.2

default : AllSizeConfig
default =
  { small = defaultSizeSmall
  , normal = defaultSizeNormal
  , large = defaultSizeLarge
  } -- TODO: mini, massive, all of them
