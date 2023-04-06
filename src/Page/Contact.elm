module Page.Contact exposing (Model, init, view)

import Element exposing (..)
import Session exposing (Session)


type alias Model =
    Session


init : Session -> Model
init session =
    session


view : Model -> { title : String, content : List (Element msg) }
view _ =
    { title = "contact"
    , content =
        [ text "contact info goes here"
        ]
    }
