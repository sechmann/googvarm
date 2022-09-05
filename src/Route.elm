module Route exposing (Route(..), fromUrl, href, parser, replaceUrl)

import Browser.Navigation as Nav
import Element exposing (Element, link)
import String
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)


type Route
    = Home
    | Contact
    | Generic String
    | ProductList String
    | Product String


parser : Parser (Route -> a) a
parser =
    oneOf
        [ Parser.map Home Parser.top
        , Parser.map Home (s "home")
        , Parser.map Generic (s "page" </> string)
        , Parser.map Contact (s "contact")
        , Parser.map Product (s "product" </> string)
        , Parser.map ProductList (s "products" </> string)
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
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse parser



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
                    [ "products", category ]

                Contact ->
                    [ "contact" ]
    in
    "#/" ++ String.join "/" pieces
