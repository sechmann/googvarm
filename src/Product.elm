module Product exposing (product)

import Stylesheet exposing (Styles(..), ProductStyles(..))
import Element exposing (..)
import Element.Attributes exposing (..)


name : String -> Element Styles variation msg
name name =
    el (Product Name) [ padding 1 ] (text name)


price : String -> Element Styles variation msg
price price =
    el (Product Price) [ padding 1 ] (text price)


description : String -> Element Styles variation msg
description description =
    el (Product Description) [ padding 1 ] (text description)


product : String -> String -> String -> Element Styles variation msg
product productName productPrice productDescription =
    row NoStyle
        []
        [ name productName
        , price productPrice
        , description productDescription
        ]
