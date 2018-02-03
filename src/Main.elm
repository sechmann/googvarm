module Main exposing (..)

import Html exposing (Html, button, div, text, img, ul, li, a)
import Html.Attributes exposing (src, class, classList, style)
import Msgs exposing (Msg(..))
import Pure
import String
import Menu exposing (menuItem)
import Navigation


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


viewPage : Maybe Navigation.Location -> Html Msg
viewPage page =
    case page of
        Just location ->
            text location.hash

        Nothing ->
            text "Nothing"


view : Model -> Html Msg
view model =
    let
        page =
            List.head model.history
    in
        div [ class Pure.grid ]
            [ div [ class "pure-u-3-5" ]
                [ img
                    [ style
                        [ ( "display", "block" )
                        , ( "margin", "auto" )
                        ]
                    , src "/assets/logo.svg"
                    ]
                    []
                , div [ class (String.join " " [ Pure.menu, Pure.menuHorizontal ]) ]
                    [ ul [ class Pure.menuList ]
                        [ menuItem "item one" "one"
                        , menuItem "item two" "two"
                        , menuItem "item three" "five"
                        , menuItem "item four" "four"
                        , menuItem "item aulon" "AULON"
                        ]
                    ]
                ]
            , div [ class "pure-u-3-5" ] [ viewPage page ]
            ]
