module Product exposing (Product, decoder, encode, view)

import Element exposing (Element, text)
import Json.Decode as Decode
import Json.Encode as Encode


type alias Product =
    { name : String
    , price : String
    , description : String
    }


encode : Product -> Encode.Value
encode product =
    Encode.object
        [ ( "name", Encode.string product.name )
        , ( "price", Encode.string product.price )
        , ( "description", Encode.string product.description )
        ]


decoder : Decode.Decoder Product
decoder =
    Decode.map3 Product
        (Decode.field "name" Decode.string)
        (Decode.field "price" Decode.string)
        (Decode.field "description" Decode.string)


view : Product -> Element msg
view product =
    Element.el [] (text product.name)
