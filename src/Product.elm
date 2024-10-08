module Product exposing (Mode(..), Product, RemoteProducts(..), decode, encode, productsDecoder, view)

import Element exposing (Element, el, paragraph, text)
import Element.Region exposing (heading)
import Http
import Json.Decode as Decode exposing (Error)
import Json.Encode as Encode
import RemoteData exposing (RemoteData)


type Mode
    = Show
    | Edit


type RemoteProducts
    = RemoteProducts (RemoteData Http.Error (List Product))


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


decode : String -> Result Error Product
decode json =
    Decode.decodeString decoder json


decoder : Decode.Decoder Product
decoder =
    Decode.map3 Product
        (Decode.field "name" Decode.string)
        (Decode.field "price" Decode.string)
        (Decode.field "description" Decode.string)


productsDecoder : Decode.Decoder (List Product)
productsDecoder =
    Decode.list
        (Decode.map3 Product
            (Decode.field "name" Decode.string)
            (Decode.field "price" Decode.string)
            (Decode.field "description" Decode.string)
        )


view : Mode -> Product -> Element msg
view mode product =
    case mode of
        Edit ->
            Element.column []
                [ el [ heading 3 ] (text ("edit " ++ product.name))
                , paragraph [] [ text product.description ]
                , el [] (text product.price)
                ]

        Show ->
            Element.column []
                [ el [ heading 3 ] (text product.name)
                , paragraph [] [ text product.description ]
                , el [] (text product.price)
                ]
