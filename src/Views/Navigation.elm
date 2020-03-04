module Views.Navigation exposing (navigation)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Route exposing (Route, href)
import Stylesheet exposing (Color(..), color)


navLinkStyle : List (Element.Attribute msg)
navLinkStyle =
    [ Font.size 16
    , Font.family
        [ Font.typeface "OpenSans"
        , Font.sansSerif
        ]
    , Font.shadow
        { offset = ( 5, 5 )
        , blur = 5
        , color = Stylesheet.color Black
        }
    , Font.color (color Black)
    , Border.widthEach
        { bottom = 1
        , left = 0
        , right = 0
        , top = 0
        }
    , Border.color (color BrickRed)
    , Element.paddingXY 6 12
    , Element.mouseOver
        [ Background.color (color Tan)
        ]
    ]


navLink : Route -> String -> Element mmg
navLink route label =
    href route navLinkStyle (text label)


navigation : Element nsg
navigation =
    Element.row [ Region.navigation ]
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
