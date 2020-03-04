module Page.Generic exposing (Model, Msg, init, toSession, update, view)

import Browser exposing (Document)
import Element exposing (..)
import Session exposing (Session)


type alias Model =
    { content : String
    , session : Session
    }


type Msg
    = NoMsg


init : Session -> ( Model, Cmd Msg )
init session =
    ( { content = "Generic page goes here"
      , session = session
      }
    , Cmd.none
    )


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


toSession : Model -> Session
toSession model =
    model.session
