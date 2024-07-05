module Example exposing (..)

import Expect
import Json.Encode exposing (string)
import Product
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
        , describe "JSON encode/decode"
            (let
                product =
                    { name = "Skinnfell", price = "10mnok,- / km^2", description = "description" }

                productJson =
                    """{
  "name": "Skinnfell",
  "price": "10mnok,- / km^2",
  "description": "description"
}"""

                decodedProduct =
                    Product.decode productJson

                encodedProduct =
                    Json.Encode.encode 2 (Product.encode product)
             in
             [ test "decode product" <|
                \_ ->
                    Expect.equal decodedProduct (Ok product)
             , test "encode product" <|
                \_ ->
                    Expect.equal encodedProduct productJson
             , test "encode/decode roundtrip" <|
                \_ ->
                    Expect.equal (Ok product) (Product.decode (Json.Encode.encode 2 (Product.encode product)))
             ]
            )
        ]
