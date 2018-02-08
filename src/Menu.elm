module Menu exposing (..)

import Stylesheet exposing (Styles(..), NavigationStyles(..))
import Element exposing (..)
import Element.Attributes exposing (..)


menuItem : String -> Element Styles variation msg
menuItem label =
    el (Nav Link) [ auto ] (text label)


navbar : Element Styles variation msg
navbar =
    column NoStyle
        [ padding 5 ]
        [ row Navbar
            [ padding 10 ]
            [ image NoStyle [] { src = "assets/logo.svg", caption = "Go og varm" }
            ]
        , row
            Navbar
            [ padding 20 ]
            [ menuItem "Item 1"
            , menuItem "Item 2"
            , menuItem "Item 3"
            , menuItem "Item 4"
            ]
        ]
