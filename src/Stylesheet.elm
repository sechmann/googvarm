module Stylesheet exposing (Color(..), color)

import Element exposing (Color, rgb255)


type Color
    = BrickRed
    | Sienna
    | Tan
    | DarkOliveGreen
    | Black
    | DarkGray
    | Gray
    | LightGray
    | OffWhite


color : Color -> Element.Color
color colorScheme =
    case colorScheme of
        Tan ->
            rgb255 82 82 82

        Gray ->
            rgb255 100 100 100

        Black ->
            rgb255 24 21 21

        Sienna ->
            rgb255 146 73 51

        DarkOliveGreen ->
            rgb255 77 48 39

        BrickRed ->
            rgb255 193 49 53

        DarkGray ->
            rgb255 41 41 41

        LightGray ->
            rgb255 242 242 242

        OffWhite ->
            rgb255 245 245 245



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
