module Example exposing (..)

import Expect exposing (Expectation)
import Route
import Test exposing (..)
import Url


suite : Test
suite =
    describe "Route module"
        [ describe "Contact route"
            [ test "parser works" <|
                \_ ->
                    let
                        url =
                            Url.fromString "http://localhost:8080/#/contact"
                    in
                    case url of
                        Just some ->
                            Expect.equal (Just Route.Contact) (Route.fromUrl some)

                        Nothing ->
                            Expect.fail "invalid url in test, get it together"
            ]
        ]
