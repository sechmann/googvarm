module Page.Editable exposing (Model, init, update, view)

import Dict exposing (Dict, get)
import Element exposing (..)
import Session exposing (Session)


type alias Model =
    { state : Dict String String
    , session : Session
    }


init : Session -> Model
init session =
    { state = Dict.empty
    , session = session
    }


editableText : Dict String String -> String -> Element msg
editableText dict key =
    case get key dict of
        Just value ->
            text value

        Nothing ->
            text "Nothing"


update : Model -> Dict String String -> Model
update model state =
    { model | state = state }


view : Model -> Element msg
view model =
    editableText model.state "post"
