module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser exposing (application)
import Html exposing (Html)
import Http
import Element exposing (..)
import Element.Input as Input
import Element.Border as Border
import Element.Font as Font
import Element.Background as Background
import Color exposing (..)


-- Main

main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init flags =
    ( Model "" []
    , Cmd.none
    )

-- Model

type alias Note = String

type alias Model =
    { note : Note
    , entries : List Note
    }

-- Update

type Msg
    = ChangeText String
    | Submit

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Submit ->
            ( { model | entries = model.note :: model.entries }, Cmd.none )

        ChangeText text ->
            ( { model | note = text }, Cmd.none )
        

-- Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- View

view : Model -> Html Msg
view model =
    layout [] <|
        column [ width <| px 500 ]
            [ row []
                [ viewInput model
                , viewOutput model
                ]
            ]


viewInput : Model -> Element Msg
viewInput model =
    column
        [ width (px 250)]
        [ Input.multiline
            [ height (px 300)
            , Border.width 1
            , Border.rounded 3
            , Border.color black
            , padding 10
            ]
            { onChange = ChangeText
            , text = ""
            , placeholder = Nothing
            , label = Input.labelAbove [] <| text ""
            , spellcheck = False
            }
        , Input.button
            [ alignRight ]
            { onPress = Just Submit
            , label = text "add the note"
            }
        ]

viewOutput : Model -> Element msg
viewOutput model =
    column
        [ ]
        (mapOutput model)

mapOutput : Model -> List (Element msg)
mapOutput model =
    List.map (\elem -> el [] <| text elem) model.entries


    
