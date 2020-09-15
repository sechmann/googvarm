module Page.ProductList exposing (..)

import Element exposing (Element, text)
import Product exposing (Product)
import Session exposing (Session)


type alias Model =
    { products : List Product
    , session : Session
    , category : String
    }


init : Session -> String -> ( Model, Cmd msg )
init session category =
    ( { products =
            [ { name = "Sengefell"
              , price = "7000,- pr kvm + tekstil"
              , description = "Fell til enkeltseng. Du kan velge pelsfarge (rase) og om du vil ha åkle eller trykk på fellen. Størrelse ca 1x1,8 meter. Syr også til dobbeltseng. Ring for bestilling! Syr gjerne til gamle åkler også."
              }
            ]
      , session = session
      , category = category
      }
    , Cmd.none
    )


view : Model -> { title : String, content : List (Element msg) }
view model =
    { title = "Products"
    , content = [ Element.column [] (Element.el [] (text model.category) :: List.map Product.view model.products) ]
    }


toSession : Model -> Session
toSession model =
    model.session
