module Route exposing (Route(..), fromUrl, href, replaceUrl)

import Browser.Navigation as Nav
import Element exposing (Element, link, text)
import Html exposing (Attribute)
import Html.Attributes as Attr
import String exposing (fromInt)
import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, int, map, oneOf, s, string)


type Route
    = Home
    | Generic String
    | ProductList String
    | Product String


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home Url.Parser.top
        , map Generic (s "page" </> string)
        , map Product (s "product" </> string)
        , map ProductList (s "productList" </> string)
        ]



-- PUBLIC HELPERS


href : Route -> List (Element.Attribute msg) -> Element msg -> Element msg
href targetRoute style label =
    link style
        { url = routeToString targetRoute
        , label = label
        }


replaceUrl : Nav.Key -> Route -> Cmd msg
replaceUrl key route =
    Nav.replaceUrl key (routeToString route)


fromUrl : Url -> Maybe Route
fromUrl url =
    -- The RealWorld spec treats the fragment like a path.
    -- This makes it *literally* the path, so we can proceed
    -- with parsing as if it had been a normal path all along.
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Url.Parser.parse parser



-- INTERNAL


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Home ->
                    [ "home" ]

                Generic name ->
                    [ "generic", name ]

                Product name ->
                    [ "product", name ]

                ProductList category ->
                    [ "productlist", category ]
    in
    "#/" ++ String.join "/" pieces
