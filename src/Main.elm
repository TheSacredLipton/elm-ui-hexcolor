module Main exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.HexColor as HexColor


hex : (Color -> Attribute msg) -> String -> Attribute msg
hex colorattr colorhex =
    case HexColor.hex colorhex of
        Just color ->
            colorattr color

        Nothing ->
            inFront <| text <| "Color conversion failed:" ++ colorhex


bgColor : String -> Attribute msg
bgColor =
    hex Background.color


view : Element msg
view =
    el
        [ width <| px 100
        , height <| px 100
        , bgColor "#212121"
        ]
        none
