module Example exposing (..)

import Expect exposing (Expectation)
import Json.Decode exposing (Decoder)
import Json.Encode
import Product exposing (Product)
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

                productString =
                    """{
  "name": "Skinnfell",
  "price": "10mnok,- / km^2",
  "description": "description"
}"""

                decodedProduct =
                    Json.Decode.decodeString Product.decoder productString

                encodedProduct =
                    Product.encode product
             in
             [ test "decode product" <|
                \_ ->
                    Expect.equal decodedProduct (Ok product)
             , test "encode product" <|
                \_ ->
                    Expect.equal (Json.Encode.encode 2 encodedProduct) productString
             , test "encode/decode roundtrip" <|
                \_ ->
                    Expect.equal (Ok product) (Json.Decode.decodeValue Product.decoder (Product.encode product))
             ]
            )
        ]
