module Credentials exposing (Credentials, Username, decoder)

import Json.Decode as Decode exposing (Decoder, string)
import Json.Decode.Pipeline exposing (custom, required)
import Json.Encode as Encode exposing (Value)
import Token exposing (Token, decoder)
import Url.Parser
import Username exposing (Username, decoder)


type Credentials
    = Credentials Username.Username Token.Token


type Username
    = Username String


decoder : Decoder Credentials
decoder =
    Decode.map2 Credentials
        (Decode.field "username" Username.decoder)
        (Decode.field "token" Token.decoder)


encode : Username -> Value
encode (Username username) =
    Encode.string username


toString : Username -> String
toString (Username username) =
    username
