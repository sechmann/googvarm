module Page.Generic exposing (Model, init, toSession, update, view)

import Browser exposing (Document)
import Element exposing (..)
import Session exposing (Session)


type alias Model =
    { content : String
    , session : Session
    }


init : Session -> Model
init session =
    { content = "Generic page goes here"
    , session = session
    }


update : Model -> String -> Model
update model content =
    { model | content = content }


view : Model -> Element msg
view model =
    text model.content


toSession : Model -> Session
toSession model =
    model.session
