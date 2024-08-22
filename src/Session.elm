module Session exposing (Session, fromViewer, navKey, products, viewer)

import Browser.Navigation as Nav
import Product exposing (Product)
import Viewer exposing (Viewer)


type Session
    = LoggedIn Nav.Key (Maybe (List Product)) Viewer.Viewer
    | Guest Nav.Key (Maybe (List Product))


viewer : Session -> Maybe Viewer
viewer session =
    case session of
        LoggedIn _ _ val ->
            Just val

        Guest _ _ ->
            Nothing


products : Session -> Maybe (List Product)
products session =
    case session of
        LoggedIn _ val _ ->
            val

        Guest _ val ->
            val


navKey : Session -> Nav.Key
navKey session =
    case session of
        LoggedIn key _ _ ->
            key

        Guest key _ ->
            key


fromViewer : Nav.Key -> Maybe Viewer -> Maybe (List Product) -> Session
fromViewer key maybeViewer p =
    case maybeViewer of
        Just viewerVal ->
            LoggedIn key p viewerVal

        Nothing ->
            Guest key p
