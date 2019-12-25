module Page.Blank exposing (view)

import Element exposing (Element)


view : { title : String, content : List (Element a) }
view =
    { title = ""
    , content = [ Element.text "" ]
    }
