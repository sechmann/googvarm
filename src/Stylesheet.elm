module Stylesheet exposing (stylesheet, Styles(..), NavigationStyles(..), ProductStyles(..))

import Color exposing (rgba)
import Style exposing (..)
import Style.Font as Font
import Style.Color as Color
import Style.Border as Border
import Style.Shadow as Shadow


colors =
    { black = rgba 16 20 25 1
    , lightblue = rgba 173 217 244 1
    , blue = rgba 71 108 155 1
    , whitesmoke = rgba 245 245 245 1
    , green2 = rgba 191 240 212 1
    }


type Styles
    = Title
    | Background
    | Subtitle
    | NoStyle
    | Product ProductStyles
    | Navbar
    | Nav NavigationStyles


type ProductStyles
    = Price
    | Name
    | Description
    | Images


type NavigationStyles
    = Link
    | Logo


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style Title
            [ Font.size 50
            , Font.typeface [ Font.font "serif" ]
            ]
        , style Subtitle
            [ --subtitle styles
              Font.size 25
            ]
        , style Background
            [ Color.background colors.blue
            ]
        , style Navbar
            [ Font.typeface [ Font.font "helvetica" ]
            , Color.background colors.blue
            ]
        , style (Nav Link)
            [ Font.size 16
            , Font.typeface [ Font.sansSerif ]
            , Font.uppercase
            , Shadow.deep
            , Color.background colors.whitesmoke
            , Color.text colors.black
            , hover [ Color.background colors.blue
            ]
            ]
        , style (Nav Logo) []
        , style (Product Price)
            [ Font.size 14
            ]
        , style (Product Name)
            [ Font.size 18
            ]
        , style (Product Description) []
        , style (Product Images) []
        ]
