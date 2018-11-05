module Page.Colors exposing (Model, init, update, view)

import Color
import Element exposing (..)
import Html exposing (Html)
import Style exposing (style, styleSheet)
import Stylesheet exposing (Styles(..))
import Views.Page exposing (frame)


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
