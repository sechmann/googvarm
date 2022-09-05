module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Api
import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (Html)
import Json.Decode exposing (Value)
import Page.Blank as Blank exposing (view)
import Page.Editable as Editable exposing (toSession)
import Page.Generic as Generic exposing (toSession)
import Page.Home as Home exposing (toSession)
import Page.ProductList as ProductList
import ProductCategory exposing (filterCategory)
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
    | ProductList String ProductList.Model


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
        _ =
            Debug.log "hei" maybeRoute

        session =
            toSession model

        initialCategories =
            [ { name = "skinnprodukter"
              , products =
                    [ { name = "Sengefell"
                      , price = "7000,- pr kvm + tekstil"
                      , description = "Fell til enkeltseng. Du kan velge pelsfarge (rase) og om du vil ha åkle eller trykk på fellen. Størrelse ca 1x1,8 meter. Syr også til dobbeltseng. Ring for bestilling! Syr gjerne til gamle åkler også."
                      }
                    ]
              }
            , { name = "saueskinn"
              , products =
                    [ { name = "Saueskinn"
                      , price = "2000,- pr stk"
                      , description = "Lorem Ipsum etc mer tekst kan komme her"
                      }
                    ]
              }
            , { name = "toving"
              , products =
                    [ { name = "Ull"
                      , price = "200,-"
                      , description = "Lorem Ipsum etc mer tekst kan komme her"
                      }
                    ]
              }
            , { name = "alpakkagarn"
              , products =
                    [ { name = "Alpakkagarn 1"
                      , price = "10,- pr g"
                      , description = "Lorem Ipsum etc mer tekst kan komme her"
                      }
                    , { name = "Alpakkagarn 2"
                      , price = "12,- pr g"
                      , description = "Lorem Ipsum etc mer tekst kan komme her"
                      }
                    ]
              }
            , { name = "ullundertøy"
              , products =
                    [ { name = "Bokser"
                      , price = "400,-"
                      , description = "Lorem Ipsum etc mer tekst kan komme her"
                      }
                    , { name = "Sokker"
                      , price = "400,- pr par"
                      , description = "Lorem Ipsum etc mer tekst kan komme her"
                      }
                    ]
              }
            , { name = "skinn"
              , products =
                    [ { name = "Kuskinn"
                      , price = "3000,-"
                      , description = "Lorem Ipsum etc mer tekst kan komme her"
                      }
                    ]
              }
            ]
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

        Just (Route.ProductList c) ->
            let
                category =
                    Maybe.withDefault c (Url.percentDecode c)
            in
            ProductList.init
                session
                (filterCategory category initialCategories)
                category
                |> updateWith (ProductList category) (\_ -> Ignored) model

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
            viewPage Page.Generic (\_ -> Ignored) (Generic.view genericModel)

        Editable editableModel ->
            viewPage Page.NotImplemented (\_ -> Ignored) Blank.view

        ProductList category productListModel ->
            viewPage Page.ProductList (\_ -> Ignored) (ProductList.view productListModel)


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

        ProductList _ model ->
            ProductList.toSession model

        _ ->
            Debug.todo "asd"
