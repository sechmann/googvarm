module Product exposing (Mode(..), Product, decoder, encode, view)

import Element exposing (Element, el, paragraph, text)
import Element.Region exposing (heading)
import Json.Decode as Decode
import Json.Encode as Encode


type Mode
    = Show
    | Edit


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
