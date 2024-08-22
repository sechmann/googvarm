module Session exposing (Session, fromViewer, navKey, products, viewer, withProducts)

import Browser.Navigation as Nav
import Product exposing (RemoteProducts)
import Viewer exposing (Viewer)


type Session
    = LoggedIn Nav.Key RemoteProducts Viewer.Viewer
    | Guest Nav.Key RemoteProducts


viewer : Session -> Maybe Viewer
viewer session =
    case session of
        LoggedIn _ _ val ->
            Just val

        Guest _ _ ->
            Nothing


products : Session -> RemoteProducts
products session =
    case session of
        LoggedIn _ val _ ->
            val

        Guest _ val ->
            val


withProducts : Session -> RemoteProducts -> Session
withProducts session p =
    case session of
        LoggedIn n _ v ->
            LoggedIn n p v

        Guest n _ ->
            Guest n p


navKey : Session -> Nav.Key
navKey session =
    case session of
        LoggedIn key _ _ ->
            key

        Guest key _ ->
            key


fromViewer : Nav.Key -> Maybe Viewer -> RemoteProducts -> Session
fromViewer key maybeViewer p =
    case maybeViewer of
        Just viewerVal ->
            LoggedIn key p viewerVal

        Nothing ->
            Guest key p
