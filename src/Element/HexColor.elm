module Element.HexColor exposing
    ( hex
    , hexa
    )

{-|

@docs hex
@docs hexa

-}

import Array
import Base16
import Element exposing (Color, rgba255)



-- INTERNAL


hexaHelper : Float -> List Int -> Maybe Color
hexaHelper alpha list =
    let
        ( r, g, b ) =
            ( rgb list 0, rgb list 1, rgb list 2 )
    in
    if List.length list == 3 then
        Just <| rgba255 r g b alpha

    else
        Nothing


rgb : List Int -> Int -> Int
rgb list index =
    list
        |> Array.fromList
        |> Array.get index
        |> Maybe.withDefault 0


sixCharacterFilter : String -> String
sixCharacterFilter s =
    if String.length s == 6 then
        s

    else
        ""



{- exposing -}


{-|

    hexa ( "000000", 0 ) -- Just (rgba 0 0 0 0)

    hexa ( "FFFFFF", 1 ) -- Just (rgba 1 1 1 1)

    hexa ( "#FFFFFF", 0 ) -- Just (rgba 1 1 1 0)

    hexa ( "FFFFFF", 10 ) -- Nothing

    hexa ( "FFFFFF", -1 ) -- Nothing

-}
hexa : ( String, Float ) -> Maybe Color
hexa ( color, alpha ) =
    if alpha <= 1 && alpha >= 0 then
        String.filter (\a -> a /= '#') color
            |> sixCharacterFilter
            |> String.toUpper
            |> Base16.decode
            |> Result.withDefault []
            |> hexaHelper alpha

    else
        Nothing


{-|

    hex "000000" -- Just (rgba 0 0 0 1)

    hex "000000" -- Just (rgba 0 0 0 1)

    hex "FFFFFF" -- Just (rgba 1 1 1 1)

    hex "#FFFFFF" -- Just (rgba 1 1 1 1)

    hex "FFF" -- Nothing

-}
hex : String -> Maybe Color
hex color =
    hexa <| ( color, 1 )
