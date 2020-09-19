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
