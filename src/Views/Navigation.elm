module Views.Navigation exposing (navigation)

import Element exposing (..)
import Element.Font as Font
import Route exposing (Route, href)
import String exposing (toUpper)
import Stylesheet exposing (Color(..), color)


navButtonStyle : List (Element.Attribute msg)
navButtonStyle =
    [ centerX, Element.paddingXY 12 12 ]


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
    , navLink (Route.ProductList "saueskinn") "Saueskinn"
    , navLink (Route.ProductList "skinnprodukter") "Skinnprodukter"
    , navLink (Route.ProductList "toving") "Ull til toving"
    , navLink (Route.ProductList "alpakkagarn") "Alpakkagarn"
    , navLink (Route.ProductList "ullgarn") "Ullgarn"
    , navLink (Route.ProductList "ullundertøy") "Ullundertøy"
    , navLink (Route.ProductList "skinn") "Skinn"
    , navLink Route.Home "Kurs"
    , navLink Route.Contact "Kontakt"
    ]
