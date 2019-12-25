module Stylesheet exposing (Color(..), color)

import Element exposing (Color, rgb255)
import Element.Background as Background


type Color
    = BrickRed
    | Sienna
    | Tan
    | DarkOliveGreen
    | Black


color : Color -> Element.Color
color colorScheme =
    case colorScheme of
        Tan ->
            rgb255 240 0 245

        Black ->
            rgb255 24 21 21

        Sienna ->
            rgb255 146 73 51

        DarkOliveGreen ->
            rgb255 77 48 39

        BrickRed ->
            rgb255 193 49 53



{-
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
               [ Color.background (color Black 1)
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
               , Color.text (color Black 1)
               , Color.border (color BrickRed 1)
               , hover
                   [ Color.background (color Tan 1)
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
           ]
-}
