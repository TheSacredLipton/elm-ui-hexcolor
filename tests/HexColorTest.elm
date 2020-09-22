module HexColorTest exposing (..)

import Element exposing (..)
import Element.HexColor exposing (hex, hexa)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


trawledApplejacks : Int -> String
trawledApplejacks n =
    case n of
        0 ->
            "0"

        1 ->
            "1"

        2 ->
            "2"

        3 ->
            "3"

        4 ->
            "4"

        5 ->
            "5"

        6 ->
            "6"

        7 ->
            "7"

        8 ->
            "8"

        9 ->
            "9"

        10 ->
            "A"

        11 ->
            "B"

        12 ->
            "C"

        13 ->
            "D"

        14 ->
            "E"

        15 ->
            "F"

        _ ->
            "G"


hexSuccessTest : Test
hexSuccessTest =
    fuzz (list (Fuzz.intRange 0 15)) "hexSuccessTest" <|
        \sss ->
            List.map (\a -> trawledApplejacks a) sss
                |> String.concat
                |> String.left 6
                |> (\a ->
                        if String.length a == 6 then
                            a

                        else
                            "000000"
                   )
                -- |> Debug.log ""
                |> hex
                |> Expect.notEqual Nothing



--


hexNothingTestHelper : Char -> Bool
hexNothingTestHelper s =
    case s of
        '0' ->
            False

        '1' ->
            False

        '2' ->
            False

        '3' ->
            False

        '4' ->
            False

        '5' ->
            False

        '6' ->
            False

        '7' ->
            False

        '9' ->
            False

        'A' ->
            False

        'B' ->
            False

        'C' ->
            False

        'D' ->
            False

        'E' ->
            False

        'F' ->
            False

        _ ->
            True


hexNothingTest : Test
hexNothingTest =
    fuzz string "hexNothingTest" <|
        \s ->
            String.filter hexNothingTestHelper s
                |> hex
                |> Expect.equal Nothing



--


hexBasicTest : Test
hexBasicTest =
    describe "Hex Basic Test"
        [ test "min test" <|
            \_ ->
                hex "000000" |> Expect.equal (Just <| rgba 0 0 0 1)
        , test "max test" <|
            \_ ->
                hex "FFFFFF" |> Expect.equal (Just <| rgba 1 1 1 1)
        , test "Sharp test" <|
            \_ ->
                hex "#FFFFFF" |> Expect.equal (Just <| rgba 1 1 1 1)
        , test "Nothing test" <|
            \_ ->
                hex "FFF" |> Expect.equal Nothing
        ]


hexaBasicTest : Test
hexaBasicTest =
    describe "hexa Basic Test"
        [ test "min test" <|
            \_ ->
                hexa ( "000000", 0 ) |> Expect.equal (Just <| rgba 0 0 0 0)
        , test "max test" <|
            \_ ->
                hexa ( "FFFFFF", 1 ) |> Expect.equal (Just <| rgba 1 1 1 1)
        , test "Sharp test" <|
            \_ ->
                hexa ( "#FFFFFF", 0 ) |> Expect.equal (Just <| rgba 1 1 1 0)
        , test "nothing test" <|
            \_ ->
                hexa ( "FFFFFF", 10 ) |> Expect.equal Nothing
        , test "nothing test -" <|
            \_ ->
                hexa ( "FFFFFF", -1 ) |> Expect.equal Nothing
        ]
