module Views.Navigation exposing (navigation)

import Element exposing (..)
import Element.Font as Font
import Route exposing (Route, href)
import String exposing (toUpper)
import Stylesheet exposing (Color(..), color)


navButtonStyle : List (Element.Attribute msg)
navButtonStyle =
    [ centerX, Element.paddingXY 6 12 ]


navLinkStyle : List (Element.Attribute msg)
navLinkStyle =
    [ Font.size 16
    , Font.family
        [ Font.typeface "Helvetica"
        , Font.sansSerif
        ]
    , Font.color (color Gray)
    , Element.mouseOver
        [ Font.color (color Black)
        ]
    ]


navLink : Route -> String -> Element mmg
navLink route label =
    href route navButtonStyle (el navLinkStyle (text (toUpper label)))


navigation : List (Element nsg)
navigation =
    [ navLink Route.Home "Hjem"
    , navLink Route.Home "Saueskinn"
    , navLink Route.Home "Skinnprodukter"
    , navLink Route.Home "Ull til toving"
    , navLink Route.Home "Alpakkagarn"
    , navLink Route.Home "Ullgarn"
    , navLink Route.Home "Ullundertøy"
    , navLink Route.Home "Kurs"
    , navLink (Route.ProductList "skinn") "Skinn"
    , navLink Route.Contact "Kontakt"
    ]
