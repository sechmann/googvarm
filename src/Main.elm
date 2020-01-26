module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Api
import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (Html)
import Json.Decode as Decode exposing (Value)
import Page.Blank as Blank exposing (view)
import Page.Editable as Editable exposing (toSession)
import Page.Generic as Generic exposing (toSession)
import Page.Home as Home exposing (toSession)
import Route exposing (Route(..))
import Session exposing (Session, navKey)
import Url exposing (Url)
import Viewer exposing (Viewer)
import Views.Page as Page exposing (view)


type Model
    = Blank
    | Redirect Session
    | NotFound Session
    | Home Home.Model
    | Generic Generic.Model
    | Editable Editable.Model


init : Maybe Viewer -> Url -> Nav.Key -> ( Model, Cmd Msg )
init maybeViewer url navKey =
    changeRouteTo (Route.fromUrl url)
        (Redirect (Session.fromViewer navKey maybeViewer))


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | Ignored
    | GotHomeMsg Home.Msg
    | GotGenericMsg Generic.Msg


changeRouteTo : Maybe Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( NotFound session, Cmd.none )

        Just Route.Home ->
            Home.init session |> updateWith Home GotHomeMsg model

        Just Route.Contact ->
            Generic.init session |> updateWith Generic GotGenericMsg model

        Just (Route.Generic page) ->
            ( model, Route.replaceUrl (Session.navKey session) (Route.Generic page) )

        Just (Route.ProductList category) ->
            ( model, Route.replaceUrl (Session.navKey session) (Route.ProductList category) )

        Just (Route.Product id) ->
            ( model, Route.replaceUrl (Session.navKey session) (Route.Product id) )


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg model ( subModel, subCmd ) =
    ( toModel subModel
    , Cmd.map toMsg subCmd
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( LinkClicked urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl (navKey (toSession model)) (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ( UrlChanged url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( Ignored, _ ) ->
            ( model
            , Cmd.none
            )

        ( GotHomeMsg subMsg, Home homeModel ) ->
            Home.update subMsg homeModel
                |> updateWith Home GotHomeMsg model

        ( _, _ ) ->
            -- Disregard messages that arrived for the wrong page.
            ( model, Cmd.none )


view : Model -> Document Msg
view model =
    let
        viewPage page toMsg config =
            let
                { title, body } =
                    Page.view (Session.viewer (toSession model)) page config
            in
            { title = title
            , body = List.map (Html.map toMsg) body
            }
    in
    case model of
        Redirect _ ->
            viewPage Page.NotImplemented (\_ -> Ignored) Blank.view

        Blank ->
            viewPage Page.NotImplemented (\_ -> Ignored) Blank.view

        NotFound session ->
            viewPage Page.NotImplemented (\_ -> Ignored) Blank.view

        Home homeModel ->
            viewPage Page.Home GotHomeMsg (Home.view homeModel)

        Generic genericModel ->
            viewPage Page.NotImplemented (\_ -> Ignored) Blank.view

        Editable editableModel ->
            viewPage Page.NotImplemented (\_ -> Ignored) Blank.view


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


main : Program Value Model Msg
main =
    Api.application Viewer.decoder
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


toSession : Model -> Session
toSession page =
    case page of
        Redirect session ->
            session

        NotFound session ->
            session

        Home model ->
            Home.toSession model

        Generic model ->
            Generic.toSession model

        Editable model ->
            Editable.toSession model

        _ ->
            Debug.todo "asd"
