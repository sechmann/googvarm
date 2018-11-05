module Stylesheet exposing (NavigationStyles(..), ProductStyles(..), Styles(..), stylesheet)

import Color exposing (..)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow


type ColorScheme
    = BrickRed
    | Sienna
    | Tan
    | DarkOliveGreen
    | Black


color : ColorScheme -> Float -> Color
color color opacity =
    case color of
        Tan ->
            rgba 207 174 159 opacity

        Black ->
            rgba 24 21 21 opacity

        Sienna ->
            rgba 146 73 51 opacity

        DarkOliveGreen ->
            rgba 77 48 39 opacity

        BrickRed ->
            rgba 193 49 53 opacity


type Styles
    = Title
    | Background
    | Subtitle
    | NoStyle
    | Product ProductStyles
    | Navbar
    | Nav NavigationStyles
    | BGRed
    | BGOrange
    | BGYellow
    | BGGreen
    | BGBlue
    | BGPurple
    | BGBrown
    | BGLightRed
    | BGLightOrange
    | BGLightYellow
    | BGLightGreen
    | BGLightBlue
    | BGLightPurple
    | BGLightBrown
    | BGDarkRed
    | BGDarkOrange
    | BGDarkYellow
    | BGDarkGreen
    | BGDarkBlue
    | BGDarkPurple
    | BGDarkBrown
    | BGWhite
    | BGLightGrey
    | BGGrey
    | BGDarkGrey
    | BGLightCharcoal
    | BGCharcoal
    | BGDarkCharcoal
    | BGBlack


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
            [ Style.Color.background (color Black 1)
            ]
        , style Navbar
            [ Font.typeface [ Font.font "helvetica" ]
            ]
        , style (Nav Link)
            [ Font.size 16
            , Font.typeface [ Font.sansSerif ]
            , Font.uppercase
            , Shadow.deep
            , Border.bottom 1
            , Style.Color.text (color Black 1)
            , Color.border (color BrickRed 1)
            , hover
                [ Style.Color.background (color Tan 1)
                , Border.dotted
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
        , style BGRed [ Color.background Color.red ]
        , style BGOrange [ Color.background Color.orange ]
        , style BGYellow [ Color.background Color.yellow ]
        , style BGGreen [ Color.background Color.green ]
        , style BGBlue [ Color.background Color.blue ]
        , style BGPurple [ Color.background Color.purple ]
        , style BGBrown [ Color.background Color.brown ]
        , style BGLightRed [ Color.background Color.lightRed ]
        , style BGLightOrange [ Color.background Color.lightOrange ]
        , style BGLightYellow [ Color.background Color.lightYellow ]
        , style BGLightGreen [ Color.background Color.lightGreen ]
        , style BGLightBlue [ Color.background Color.lightBlue ]
        , style BGLightPurple [ Color.background Color.lightPurple ]
        , style BGLightBrown [ Color.background Color.lightBrown ]
        , style BGDarkRed [ Color.background Color.darkRed ]
        , style BGDarkOrange [ Color.background Color.darkOrange ]
        , style BGDarkYellow [ Color.background Color.darkYellow ]
        , style BGDarkGreen [ Color.background Color.darkGreen ]
        , style BGDarkBlue [ Color.background Color.darkBlue ]
        , style BGDarkPurple [ Color.background Color.darkPurple ]
        , style BGDarkBrown [ Color.background Color.darkBrown ]
        , style BGWhite [ Color.background Color.white ]
        , style BGLightGrey [ Color.background Color.lightGrey ]
        , style BGGrey [ Color.background Color.grey ]
        , style BGDarkGrey [ Color.background Color.darkGrey ]
        , style BGLightCharcoal [ Color.background Color.lightCharcoal ]
        , style BGCharcoal [ Color.background Color.charcoal ]
        , style BGDarkCharcoal [ Color.background Color.darkCharcoal ]
        , style BGBlack [ Color.background Color.black ]
        ]
