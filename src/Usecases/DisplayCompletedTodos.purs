module Usecases.DisplayCompletedTodos where

import Prelude

import Data.Either (Either(..))
import Domains.Error (Error)
import Domains.Todo (Todos, Logics)
import Domains.User (UserId)
import Effect.Aff (Aff)

type TodoPort = {
  findTodos :: UserId -> Aff (Either Error Todos)
}

type TodoOutputPort = {
  display :: Todos -> Aff Unit,
  displayError :: Error -> Aff Unit
}

execute 
  :: UserId
  -> Logics
  -> TodoPort
  -> TodoOutputPort
  -> Aff Unit
execute id logics todoPort outputPort = do
  result <- todoPort.findTodos id
  case result of
    Right todos -> outputPort.display $ logics.completed todos
    Left e -> outputPort.displayError e
