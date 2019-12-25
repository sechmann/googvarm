module Token exposing (Token, decoder)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Url.Parser


type Token
    = Token String


decoder : Decoder Token
decoder =
    Decode.map Token Decode.string


encode : Token -> Value
encode (Token token) =
    Encode.string token


toString : Token -> String
toString (Token token) =
    token
