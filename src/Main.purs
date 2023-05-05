module Main where

import Prelude

import Domains.Todo (logics)
import Domains.User (UserId(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Gateways.TodoGateway (createTodoPort)
import Presenters.TodoPresenter (createOutputPort)
import Usecases.DisplayCompletedTodos (execute)

main :: Effect Unit
main =
  launchAff_ do
    let
      todoLogics = logics
      todoPort = createTodoPort
      outputPort = createOutputPort
    execute (UserId 1) todoLogics todoPort outputPort