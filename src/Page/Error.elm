module Page.Error exposing (..)

import Element exposing (Element, text)
import Element.Region as Region
import Session exposing (Session)


type alias Model =
    { error : String
    , session : Session
    }


init : Session -> String -> ( Model, Cmd msg )
init session error =
    ( { session = session
      , error = error
      }
    , Cmd.none
    )


view : Model -> { title : String, content : List (Element msg) }
view model =
    { title = "Products"
    , content =
        [ Element.column []
            [ Element.el [ Region.heading 2 ] (text "Oops. Something went wrong")
            , Element.el [] (text model.error)
            ]
        ]
    }


toSession : Model -> Session
toSession model =
    model.session
