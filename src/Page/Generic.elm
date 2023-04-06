module Page.Generic exposing (Model, init, update, view)

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


view : Model -> { title : String, content : List (Element msg) }
view model =
    { title = ""
    , content =
        [ text model.content
        ]
    }
