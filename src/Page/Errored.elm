module Page.Errored exposing (PageLoadError, pageLoadError, view)

import Html exposing (Html)
import Views.Page exposing (ActivePage)
import Stylesheet exposing (stylesheet, Styles(..))
import Element exposing (..)
import Element.Attributes exposing (..)


type PageLoadError
    = PageLoadError Model


type alias Model =
    { activePage : ActivePage, errorMessage : String }


pageLoadError : ActivePage -> String -> PageLoadError
pageLoadError activePage errorMessage =
    PageLoadError { activePage = activePage, errorMessage = errorMessage }


view : PageLoadError -> Html msg
view (PageLoadError model) =
    Element.layout stylesheet <|
        column Background
            [ alignLeft, width (percent 100) ]
            [ text model.errorMessage ]
