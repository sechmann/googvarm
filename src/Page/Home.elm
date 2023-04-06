module Page.Home exposing (Model, Msg, init, update, view)

import Element exposing (Element, centerX, el, fill, image, link, padding, paragraph, row, spacing, text, textColumn, width)
import Element.Border exposing (shadow)
import Element.Font as Font
import Session exposing (Session)
import Stylesheet exposing (Color(..), color)


type Msg
    = HomeImageChange


type alias Model =
    { images : List { src : String, caption : String }
    , post : String
    , session : Session
    }


init : Session -> ( Model, Cmd Msg )
init session =
    ( { images =
            [ { src = "front1.jpg", caption = "" }
            , { src = "front2.jpg", caption = "" }
            , { src = "front3.jpg", caption = "" }
            , { src = "front4.jpg", caption = "" }
            ]
      , post = """Velkommen til gårdsbutikken Go’ og varm på Søndre Holm.

Her selges norske saueskinn og skinnfeller, ull og silke til toving, filting og spinning, alpakkagarn fra Du Store Alpakka, ullgarn fra bl.a. Leine Merino, Askeladden og Hillesvåg, mønster, knapper, ulltøy, ullsåler og mye annet rart!

På hjemmesiden vises bare et lite utvalg. Skinnfeller sys på bestilling. Åpent tirsdag og torsdag kl. 10.00-20.00."""
      , session = session
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HomeImageChange ->
            ( model, Cmd.none )


img : { src : String, caption : String } -> Element msg
img i =
    link [ centerX, shadow { offset = ( 2.0, 2.0 ), size = 1, blur = 15.0, color = color Gray } ]
        { url = "/assets/" ++ i.src
        , label =
            image
                []
                { src = "/assets/thumb." ++ i.src
                , description = i.caption
                }
        }


view : Model -> { title : String, content : List (Element msg) }
view model =
    { title = "Hjem"
    , content =
        [ row [ width fill, padding 10, spacing 10 ] (List.map img model.images)
        , row [ width fill, padding 10 ]
            [ textColumn [ centerX, Font.size 16, Font.center ]
                [ paragraph []
                    [ el [ padding 5 ]
                        (text model.post)
                    ]
                ]
            ]
        ]
    }
