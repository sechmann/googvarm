module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Api
import Browser exposing (Document)
import Browser.Navigation as Nav
import Html
import Http
import Json.Decode exposing (Value)
import Page.Contact as Contact
import Page.Error as Error
import Page.Home as Home
import Page.ProductList as ProductList
import Product exposing (Product, productsDecoder)
import ProductCategory exposing (filterCategory)
import Route exposing (Route)
import Session exposing (Session, navKey)
import Url exposing (Url)
import Viewer exposing (Viewer)
import Views.Page as Page exposing (view)


type Model
    = Redirect Session
    | NotFound Session
    | Home Home.Model
    | Contact Contact.Model
    | ProductList String ProductList.Model


init : Maybe Viewer -> Url -> Nav.Key -> ( Model, Cmd Msg )
init maybeViewer url navKey =
    let
        ( initialModel, initialCmd ) =
            changeRouteTo (Route.fromUrl url)
                (Redirect (Session.fromViewer navKey maybeViewer Nothing))
    in
    ( initialModel
    , Cmd.batch
        [ initialCmd
        , Http.get
            { url = "/products"
            , expect = Http.expectJson GotInitialProductsResponse productsDecoder
            }
        ]
    )


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | Ignored
    | GotHomeMsg Home.Msg
    | GotProductListMsg ProductList.Msg
    | GotInitialProductsResponse (Result Http.Error (List Product))


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
            ( Contact (Contact.init session), Cmd.none )

        Just (Route.ProductList c) ->
            let
                category =
                    Maybe.withDefault c (Url.percentDecode c)
            in
            ProductList.init
                session
                (Session.products session)
                category
                |> updateWith (ProductList category) (\_ -> Ignored) model

        Just (Route.Product id) ->
            ( model, Route.replaceUrl (Session.navKey session) (Route.Product id) )


updateWith : (subModel -> Model) -> (subMsg -> Msg) -> Model -> ( subModel, Cmd subMsg ) -> ( Model, Cmd Msg )
updateWith toModel toMsg _ ( subModel, subCmd ) =
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
        viewPage toMsg config =
            let
                { title, body } =
                    Page.view (Session.viewer (toSession model)) config
            in
            { title = title
            , body = List.map (Html.map toMsg) body
            }
    in
    case model of
        Redirect session ->
            viewPage (\_ -> Ignored) (Error.view { error = "not implemented", session = session })

        NotFound session ->
            viewPage (\_ -> Ignored) (Error.view { error = "not implemented", session = session })

        Contact m ->
            viewPage (\_ -> Ignored) (Contact.view m)

        Home homeModel ->
            viewPage GotHomeMsg (Home.view homeModel)

        ProductList _ productListModel ->
            viewPage GotProductListMsg (ProductList.view productListModel)


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
toSession model =
    case model of
        Redirect session ->
            session

        NotFound session ->
            session

        Home m ->
            m.session

        Contact m ->
            m

        ProductList _ m ->
            m.session
