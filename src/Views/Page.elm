module Views.Page exposing (ActivePage(..), frame)

import Stylesheet exposing (stylesheet, Styles(..), NavigationStyles(..))
import Route exposing (Route, href)
import Html exposing (Html)
import Element exposing (..)
import Element.Attributes exposing (..)


type ActivePage
    = Home
    | Courses
    | Contact


navlink route alt =
    href route (el (Nav Link) [ paddingXY 6 12 ] (text alt))


frame : List (Element Styles variation msg) -> Html msg
frame content =
    let
        siteHeader =
            header NoStyle
                []
                (image NoStyle [ center ] { src = "assets/logo.svg", caption = "Go og varm" })

        siteNav =
            navigation Navbar
                []
                { name = "Main navigation"
                , options =
                    [ navlink Route.Home "Hjem"
                    , navlink Route.Home "Saueskinn"
                    , navlink Route.Home "Skinnprodukter"
                    , navlink Route.Home "Ull til toving"
                    , navlink Route.Home "Alpakkagarn"
                    , navlink Route.Home "Ullgarn"
                    , navlink Route.Home "Ullundertøy"
                    , navlink Route.Home "Kurs"
                    , navlink Route.Contact "Kontakt"
                    ]
                }

        siteFooter =
            footer NoStyle
                [ center ]
                (text "Footer")
    in
        Element.viewport stylesheet <|
            column NoStyle
                [ center, width (percent 100), height (percent 100) ]
                [ siteHeader
                , siteNav
                , column NoStyle [ center ] content
                , siteFooter
                ]
