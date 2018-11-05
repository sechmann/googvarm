module Route exposing (Route(..), fromLocation, href, modifyUrl)

import Element exposing (link)
import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string)


type Route
    = Page String
    | ProductList Int
    | Product Int



routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map Topic   (s "page" </> string)
    , map Blog    (s "product" </> int)
    , map Blog    (s "productList" </> int)
    ]

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
