module Page.ProductList exposing (Model, Msg(..), init, update, view)

import Element exposing (Element, text)
import Element.Region as Region
import Http
import Json.Decode exposing (Error(..))
import Product exposing (RemoteProducts(..))
import RemoteData exposing (RemoteData(..))
import Session exposing (Session, products)
import Url exposing (Protocol(..))


type alias Model =
    { session : Session
    , category : String
    , test : Int
    }


type Msg
    = None


init : Session -> String -> ( Model, Cmd msg )
init session category =
    ( { session = session
      , category = category
      , test = 0
      }
    , Cmd.none
    )


update : msg -> Model -> ( Model, Cmd msg )
update _ model =
    ( { model | test = model.test + 1 }, Cmd.none )


view : Model -> { title : String, content : List (Element msg) }
view model =
    { title = "Products"
    , content =
        [ Element.column []
            [ Element.el [ Region.heading 2 ] (text model.category)
            , Element.column []
                (case Session.products model.session of
                    RemoteProducts RemoteData.NotAsked ->
                        [ Element.el [] (text "No products...") ]

                    RemoteProducts RemoteData.Loading ->
                        Debug.todo "branch 'RemoteProducts Loading' not implemented"

                    RemoteProducts (RemoteData.Failure f) ->
                        [ Element.el [] (text ("Http error: " ++ errToString f)) ]

                    RemoteProducts (RemoteData.Success products) ->
                        Element.el [] (text (String.fromInt model.test)) :: List.map (Product.view Product.Show) products
                )
            ]
        ]
    }


errToString : Http.Error -> String
errToString e =
    case e of
        Http.BadUrl url ->
            "BadUrl: " ++ url

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "NetworkError"

        Http.BadStatus statusCode ->
            "BadStatus: " ++ String.fromInt statusCode

        Http.BadBody body ->
            "BadBody: " ++ body
