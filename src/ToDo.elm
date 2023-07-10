module ToDo exposing (..)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

main : Program () Model Msg
main = Browser.sandbox { init = init, update = update, view = view}

type alias Model = 
    {
        todos: List String
        ,newTodo: String
    }

init: Model
init = 
    {
        todos= []
        ,newTodo= ""
    }

type Msg = AddTodoToList | GetNewTodo String | DeleteTodo Int 


removeAtIndex: Int -> List a -> List a
removeAtIndex index list = 
   case List.drop index list of
        [] ->
            list

        _ :: tail ->
            List.take index list ++ tail

update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTodoToList ->
            { model | todos = model.newTodo :: model.todos, newTodo = ""}
        GetNewTodo new ->
            { model | newTodo = new }
        DeleteTodo id ->
            {model | todos = removeAtIndex id model.todos }
        -- GetDeleteTodo id -> 
        --     {model | delTodoId = id}

view: Model -> Html Msg
view model = 
    div [ 
           style "width" "100vw", style "height" "100vh", style "display" "flex", style "flex-direction" "column", style "gap" "10px", style "align-items" "center", style "justify-content" "center" 
        ]
        [ 
            div [ style "display" "flex", style "flex-direction" "row", style "gap" "5px" ] 
            [
                input [ placeholder "Add new Todo", value model.newTodo, onInput GetNewTodo, style "padding" "10px 6px" ] [] 
                ,button [ onClick AddTodoToList ] [ text "Add new Todo" ]
            ]
            ,div [ style "display" "flex", style "flex-direction" "column-reverse", style "gap" "5px" ]
                (List.indexedMap (\index todo -> div [style "display" "flex", style "flex-direction" "row", style "gap" "5px", style "align-items" "center"] [text todo, button[onClick (DeleteTodo index)] [text "Delete Task"] ]) model.todos)
        ]