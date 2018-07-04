module Page.Colors exposing (Model, init, update, view)

import Element exposing (..)
import Style exposing (styleSheet, style)
import Views.Page exposing (frame)
import Color
import Html exposing (Html)
import Stylesheet exposing (Styles(..))


type alias Model =
    List ( String, Styles )


init : Model
init =
    [ ( "red", BGRed )
    , ( "orange", BGOrange )
    , ( "yellow", BGYellow )
    , ( "green", BGGreen )
    , ( "blue", BGBlue )
    , ( "purple", BGPurple )
    , ( "brown", BGBrown )
    , ( "lightRed", BGLightRed )
    , ( "lightOrange", BGLightOrange )
    , ( "lightYellow", BGLightYellow )
    , ( "lightGreen", BGLightGreen )
    , ( "lightBlue", BGLightBlue )
    , ( "lightPurple", BGLightPurple )
    , ( "lightBrown", BGLightBrown )
    , ( "darkRed", BGDarkRed )
    , ( "darkOrange", BGDarkOrange )
    , ( "darkYellow", BGDarkYellow )
    , ( "darkGreen", BGDarkGreen )
    , ( "darkBlue", BGDarkBlue )
    , ( "darkPurple", BGDarkPurple )
    , ( "darkBrown", BGDarkBrown )
    , ( "white", BGWhite )
    , ( "lightGrey", BGLightGrey )
    , ( "grey", BGGrey )
    , ( "darkGrey", BGDarkGrey )
    , ( "lightCharcoal", BGLightCharcoal )
    , ( "charcoal", BGCharcoal )
    , ( "darkCharcoal", BGDarkCharcoal )
    , ( "black", BGBlack )
    ]


update : Model -> Model
update model =
    model


showColor t =
    let
        ( colorName, color ) =
            t
    in
        row
            color
            []
            [ text colorName ]


view : Model -> Html msg
view model =
    List.map showColor model |> frame
