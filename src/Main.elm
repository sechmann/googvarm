module Main exposing (..)

import Html exposing (Html)
import Navigation exposing (Location)
import Json.Decode as Decode exposing (Value)
import Route exposing (Route)
import Page.Home as Home
import Page.Contact as Contact
import Page.Colors as Colors
import Page.Errored as Errored exposing (PageLoadError)
import Task exposing (Task)
import Util exposing ((=>))
import Views.Page as Page exposing (ActivePage)


type Page
    = Blank
    | NotFound
    | Errored PageLoadError
    | Home Home.Model
    | Contact Contact.Model
    | Colors Colors.Model


type PageState
    = Loaded Page
    | TransitioningFrom Page


init : Value -> Location -> ( Model, Cmd Msg )
init val location =
    setRoute (Route.fromLocation location)
        { pageState = Loaded initialPage }


initialPage : Page
initialPage =
    Blank



-- MODEL


type alias Model =
    { pageState : PageState
    }



-- UPDATE


type Msg
    = SetRoute (Maybe Route)
    | HomeLoaded (Result PageLoadError Home.Model)


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    let
        transition toMsg task =
            { model | pageState = TransitioningFrom (getPage model.pageState) }
                => Task.attempt toMsg task

        errored =
            pageErrored model
    in
        case maybeRoute of
            Nothing ->
                { model | pageState = Loaded NotFound } => Cmd.none

            Just Route.Home ->
                { model | pageState = Loaded (Home Home.init) } => Cmd.none

            Just Route.Contact ->
                { model | pageState = Loaded (Contact Contact.init) } => Cmd.none

            Just Route.Colors ->
                { model | pageState = Loaded (Colors Colors.init) } => Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    updatePage (getPage model.pageState) msg model


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    let
        toPage toModel toMsg subUpdate subMsg subModel =
            let
                ( newModel, newCmd ) =
                    subUpdate subMsg subModel
            in
                ( { model | pageState = Loaded (toModel newModel) }, Cmd.map toMsg newCmd )
    in
        case ( msg, page ) of
            ( SetRoute route, _ ) ->
                setRoute route model

            ( HomeLoaded (Ok subModel), _ ) ->
                { model | pageState = Loaded (Home subModel) } => Cmd.none

            ( HomeLoaded (Err error), _ ) ->
                { model | pageState = Loaded (Errored error) } => Cmd.none



-- VIEW


viewPage : Bool -> Page -> Html msg
viewPage isLoading page =
    case page of
        Home subModel ->
            Home.view subModel

        Blank ->
            Debug.crash "TODO"

        Errored subModel ->
            Errored.view subModel

        NotFound ->
            Debug.crash "TODO"

        Contact subModel ->
            Contact.view subModel

        Colors subModel ->
            Colors.view subModel


view : Model -> Html msg
view model =
    case model.pageState of
        Loaded page ->
            viewPage False page

        TransitioningFrom page ->
            viewPage True page


getPage : PageState -> Page
getPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page


pageErrored : Model -> ActivePage -> String -> ( Model, Cmd msg )
pageErrored model activePage errorMessage =
    let
        error =
            Errored.pageLoadError activePage errorMessage
    in
        { model | pageState = Loaded (Errored error) } => Cmd.none


main : Program Value Model Msg
main =
    Navigation.programWithFlags (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }
