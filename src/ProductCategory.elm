module ProductCategory exposing (filterCategory)

import List exposing (filter, head)
import Product exposing (Product)


type alias Category =
    { name : String
    , products : List Product
    }


isCategory : String -> Category -> Bool
isCategory name category =
    category.name == name


filterCategory : String -> List Category -> List Product
filterCategory categoryName categories =
    case head (filter (isCategory categoryName) categories) of
        Just p ->
            p.products

        Nothing ->
            []
