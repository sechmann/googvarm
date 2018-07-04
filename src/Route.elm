module Route exposing (Route(..), fromLocation, href, modifyUrl)

import UrlParser as Url exposing ((</>), Parser, oneOf, parseHash, s, string)
import Element exposing (link)
import Navigation exposing (Location)


type Route
    = Home
    | Contact
    | Colors


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Home (s "")
        , Url.map Contact (s "contact")
        , Url.map Colors (s "colors")
        ]


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Home ->
                    []

                Contact ->
                    [ "contact" ]
                Colors ->
                    [ "Colors" ]
    in
        "#/" ++ String.join "/" pieces



-- Public helpers --


href :
    Route
    -> Element.Element style variation msg
    -> Element.Element style variation msg
href route =
    link (routeToString route)


modifyUrl : Route -> Cmd msg
modifyUrl =
    routeToString >> Navigation.modifyUrl


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Home
    else
        parseHash route location
