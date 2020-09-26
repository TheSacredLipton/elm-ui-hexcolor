module Main exposing (main)

import Element exposing (..)
import Element.Background as Background
import Element.HexColor as HexColor
import Html exposing (Html)


hex : (Color -> Attribute msg) -> String -> Attribute msg
hex colorattr colorhex =
    case HexColor.hex colorhex of
        Just color ->
            colorattr color

        Nothing ->
            inFront <| text <| "Color conversion failed:" ++ colorhex


main : Html msg
main =
    layout [] <|
        column
            []
            [ el
                [ width <| px 100
                , height <| px 100
                , hex Background.color "#212121"
                ]
                none
            , el
                [ width <| px 100
                , height <| px 100
                , hex Background.color "#2121"
                ]
                none
            ]