module Page.Home exposing (Model, init, update, view)

import Stylesheet exposing (Styles(..))
import Element exposing (column, row, text, link, image)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Views.Page exposing (frame)


type alias Model =
    { images : List { src : String, caption : String }
    , post : String
    }


init : Model
init =
    { images =
        [ { src = "front1.jpg", caption = "" }
        , { src = "front2.jpg", caption = "" }
        , { src = "front3.jpg", caption = "" }
        , { src = "front4.jpg", caption = "" }
        ]
    , post = """Velkommen til gårdsbutikken Go’ og varm på Søndre Holm.

Her selges norske saueskinn og skinnfeller, ull og silke til toving, filting og spinning, alpakkagarn fra Du Store Alpakka, ullgarn fra bl.a. Leine Merino, Askeladden og Hillesvåg, mønster, knapper, ulltøy, ullsåler og mye annet rart!

På hjemmesiden vises bare et lite utvalg. Skinnfeller sys på bestilling. Åpent tirsdag og torsdag kl. 10.00-20.00."""
    }


update : Model -> String -> Model
update model post =
    { model | post = post }


img : { src : String, caption : String } -> Element.Element Styles variation msg
img i =
    link ("/assets/" ++ i.src)
        (image NoStyle
            []
            { src = ("assets/thumb." ++ i.src)
            , caption = i.caption
            }
        )


view : Model -> Html msg
view model =
    [ row NoStyle
        []
        (List.map img model.images)
    , text model.post
    ]
        |> frame
