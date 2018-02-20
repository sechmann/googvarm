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


frame : List (Element Styles variation msg) -> Html msg
frame content =
    let
        siteHeader =
            header NoStyle
                [ center ]
                (image NoStyle [] { src = "assets/logo.svg", caption = "Go og varm" })

        siteNav =
            navigation Navbar
                [ center ]
                { name = "Main navigation"
                , options =
                    [ href Route.Home (el (Nav Link) [] (text "Home"))
                    , href Route.Contact (el (Nav Link) [] (text "Contact"))
                    ]
                }

        siteFooter =
            footer NoStyle
                [ center ]
                (text "Footer")
    in
        Element.viewport stylesheet <|
            column NoStyle
                [ center ]
                [ siteHeader
                , siteNav
                , column NoStyle [ center ] content
                , siteFooter
                ]
