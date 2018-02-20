module Page.Home exposing (Model, init, update, view)

import Stylesheet exposing (Styles(..))
import Element exposing (column, text)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Views.Page exposing (frame)


type alias Model =
    { post : String }


init : Model
init =
    { post = "Home page goes here" }


update : Model -> String -> Model
update model post =
    { model | post = post }


view : Model -> Html msg
view model =
    [ text model.post
    ]
        |> frame
