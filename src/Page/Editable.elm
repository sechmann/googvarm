module Page.Editable exposing (Model, init, update, view)

import Dict exposing (Dict, empty, get)
import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Views.Page exposing (frame)


type alias Model =
    { state : Dict String String }


init : { state : Dict String String }
init =
    { state = Dict.empty }


editableText : Dict String String -> String -> Element style variation msg
editableText dict key =
    case get key dict of
        Just value ->
            text value

        Nothing ->
            text "Nothing"


update : Model -> Dict String String -> Model
update model state =
    { model | state = state }


view : Model -> Html msg
view model =
    [ editableText model.state "post"
    ]
        |> frame
