module Menu exposing (menuItem)

import Html exposing (Html, li, a, text)
import Html.Attributes exposing (class, href)
import Pure


menuItem : String -> String -> Html msg
menuItem itemText path =
    li [ class Pure.menuItem ] [ a [ class Pure.menuLink, href ("#" ++ path) ] [ text itemText ] ]
