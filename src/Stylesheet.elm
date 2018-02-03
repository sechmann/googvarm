module Stylesheet exposing (..)

import Styles exposing (GoogvarmStyles(..))
import Style exposing (..)
import Style.Font as Font


stylesheet =
    Style.styleSheet [ Style.style Title [ Font.size 50 ] ]
