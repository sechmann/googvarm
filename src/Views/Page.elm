module Views.Page exposing (Page(..), view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Region as Region
import Html exposing (Html)
import Route exposing (Route, href)
import Stylesheet exposing (color)
import Viewer exposing (Viewer)
import Views.Navigation exposing (navigation)


type Page
    = Home
    | Courses
    | Contact
    | Generic
    | Blog
    | NotImplemented


view : Maybe Viewer -> Page -> { title : String, content : List (Element msg) } -> Document msg
view maybeViewer page { title, content } =
    let
        siteHeader =
            image [] { src = "assets/logo.svg", description = "Go og varm" }

        siteNav =
            navigation

        siteFooter =
            text "Footer"
    in
    { title = title ++ " - Go' og varm"
    , body =
        [ Element.layout []
            (column []
                [ row [ Region.heading 1 ] [ siteHeader ]
                , row [ Region.navigation ] [ siteNav ]
                , row [ Region.mainContent ] content
                , row [ Region.footer ] [ siteFooter ]
                ]
            )
        ]
    }


pageToTitle : Page -> String
pageToTitle page =
    case page of
        Home ->
            "Hjem"

        Courses ->
            "Kurs"

        Contact ->
            "Kontakt"

        NotImplemented ->
            "Ikke implementert"

        Blog ->
            "Blog"

        Generic ->
            "Generic"
