module Views.Page exposing (Page(..), view)

import Browser exposing (Document)
import Element exposing (..)
import Element.Background
import Element.Border
import Element.Font as Font
import Element.Region as Region
import Stylesheet exposing (Color(..), color)
import Viewer exposing (Viewer)
import Views.Navigation exposing (navigation)


type Page
    = Home
    | Courses
    | Contact
    | Generic
    | Blog
    | NotImplemented
    | ProductList


view : Maybe Viewer -> Page -> { title : String, content : List (Element msg) } -> Document msg
view maybeViewer page { title, content } =
    let
        siteHeader =
            column [ width fill ]
                [ row
                    [ width fill
                    , padding 10
                    , Font.size 12
                    , spacing 20
                    , alignLeft
                    , Element.Background.color (color LightGray)
                    , Font.color (color Gray)
                    , Element.Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                    , Element.Border.solid
                    ]
                    [ text "92 62 12 97"
                    , text "TIR/TOR 10:00-20:00"
                    , link [ alignRight ] { url = "https://goo.gl/maps/g26t1xp4ph33bN4G7", label = text "Ulvedalsveien 150, 2020 Skedsmokorset" }
                    ]
                , row [ width fill, padding 30 ]
                    [ image [ centerX ] { src = "assets/logo.svg", description = "Go og varm" }
                    ]
                ]

        siteNav =
            navigation

        siteFooter =
            row [ centerX, alignBottom ] [ text "Footer" ]
    in
    { title = title ++ " - Go' og varm"
    , body =
        [ Element.layout [ width fill ]
            -- (column [ Element.explain Debug.todo, width fill ]
            (column [ width fill ]
                [ row [ width fill, Region.heading 1 ] [ siteHeader ]
                , row [ width fill, Region.navigation ] siteNav
                , row [ width fill, Region.mainContent ] [ column [ width fill, paddingXY 150 20, Font.family [ Font.typeface "Roboto", Font.sansSerif ] ] content ]
                , row [ width fill, Region.footer ] [ siteFooter ]
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

        ProductList ->
            "ProductListTitleFromPage"
