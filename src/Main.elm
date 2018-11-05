module Main exposing (Model, Msg(..), Page(..), PageState(..), init, main, subscriptions, update, view, viewLink)

import Json.Decode as Decode exposing (Value)
import Page.Colors as Colors
import Page.Contact as Contact
import Page.Editable as Editable
import Page.Errored as Errored exposing (PageLoadError)
import Page.Home as Home
import Route exposing (Route)
import Task exposing (Task)
import Util exposing ((=>))
import Views.Page as Page exposing (ActivePage)


type Page
    = Blank
    | NotFound
    | Errored PageLoadError
    | Home Home.Model
    | Contact Contact.Model
    | Editable Editable.Model
    | Colors Colors.Model


type PageState
    = Loaded Page
    | TransitioningFrom Page


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url, Cmd.none )


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


view : Model -> Browser.Document Msg
view model =
    { title = "URL Interceptor"
    , body =
        [ text "The current URL is: "
        , b [] [ text (Url.toString model.url) ]
        , ul []
            [ viewLink "/home"
            , viewLink "/profile"
            , viewLink "/reviews/the-century-of-the-self"
            , viewLink "/reviews/public-opinion"
            , viewLink "/reviews/shah-of-shahs"
            ]
        ]
    }


viewLink : String -> Html msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]



subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
