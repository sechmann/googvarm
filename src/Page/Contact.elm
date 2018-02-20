module Page.Contact exposing (Model, init, update, view)

import Stylesheet exposing (stylesheet, Styles(..))
import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Views.Page exposing (frame)


type alias Model =
    { post : String }


init : Model
init =
    { post = "Contact page goes here" }


update : Model -> String -> Model
update model post =
    { model | post = post }


view : Model -> Html msg
view model =
    [ text model.post
    ]
        |> frame
