module Stylesheet exposing (stylesheet, Styles(..), NavigationStyles(..), ProductStyles(..))

import Color exposing (rgba)
import Style exposing (..)
import Style.Font as Font
import Style.Color as Color


colors =
    { mauve = rgba 176 161 186 1
    , blue1 = rgba 165 181 191 1
    , blue2 = rgba 171 200 199 1
    , green1 = rgba 184 226 200 1
    , green2 = rgba 191 240 212 1
    }


type Styles
    = Title
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
        , style Navbar
            [ Color.background colors.blue1
            , Font.typeface [ Font.font "helvetica" ]
            ]
        , style (Nav Link)
            [ Font.size 12
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
