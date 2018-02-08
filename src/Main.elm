module Main exposing (..)

import Msgs exposing (Msg(..))
import Html exposing (Html)
import Navigation
import Element exposing (..)
import Menu exposing (navbar)
import Stylesheet exposing (stylesheet, Styles(..), NavigationStyles(..))


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model [ location ]
    , Cmd.none
    )



-- MODEL


type alias Model =
    { history : List Navigation.Location
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | history = location :: model.history }
            , Cmd.none
            )



-- VIEW


viewPage : Maybe Navigation.Location -> Element style variation msg
viewPage page =
    case page of
        Just location ->
            text location.hash

        Nothing ->
            text "Nothing"


view : Model -> Html msg
view model =
    let
        page =
            List.head model.history
    in
        Element.layout stylesheet <|
            column NoStyle
                []
                [ navbar
                , el NoStyle [] (viewPage page)
                ]
