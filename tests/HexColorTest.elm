module HexColorTest exposing (..)

import Element exposing (..)
import Element.HexColor exposing (hex, hexa)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe "color"
        [ test "1" <|
            \_ ->
                hex "411111" |> Expect.equal (Just <| rgba 0.2549019607843137 0.06666666666666667 0.06666666666666667 1)
        , test "2" <|
            \_ ->
                hex "000000" |> Expect.equal (Just <| rgba 0 0 0 1)
        , test "3" <|
            \_ ->
                hex "FFFFFF" |> Expect.equal (Just <| rgba 1 1 1 1)
        , test "4" <|
            \_ ->
                hex "#FFFFFF" |> Expect.equal (Just <| rgba 1 1 1 1)
        , test "5" <|
            \_ ->
                hex "#FFFFFG" |> Expect.equal Nothing
        , test "6" <|
            \_ ->
                hex "#FFFFFあ" |> Expect.equal Nothing
        ]
