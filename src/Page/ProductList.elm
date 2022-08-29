module Page.ProductList exposing (..)

import Element exposing (Element, text)
import Element.Region as Region
import Product exposing (Product)
import Session exposing (Session)


type alias Model =
    { products : List Product
    , session : Session
    , category : String
    , test : Int
    }


init : Session -> List Product -> String -> ( Model, Cmd msg )
init session products category =
    ( { products = products
      , session = session
      , category = category
      , test = 0
      }
    , Cmd.none
    )


update : msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( { model | test = model.test + 1 }, Cmd.none )


view : Model -> { title : String, content : List (Element msg) }
view model =
    { title = "Products"
    , content =
        [ Element.column []
            [ Element.el [ Region.heading 2 ] (text model.category)
            , Element.column []
                (Element.el [] (text (String.fromInt model.test)) :: List.map Product.view model.products)
            ]
        ]
    }


toSession : Model -> Session
toSession model =
    model.session
