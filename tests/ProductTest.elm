module ProductTest exposing (..)

import Expect
import Json.Encode
import Product
import Test exposing (..)


suite : Test
suite =
    describe "JSON encode/decode"
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
