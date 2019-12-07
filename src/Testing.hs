module Testing
  ( dummyCondition
  , dummyTransition
  , dummyState
  , dummyTape
  , dummyMachine
  ) where

import TuringMachine

dummyCondition :: Int -> Condition
dummyCondition 0 = (== 0)
dummyCondition 1 = (== 3)

dummyTransition :: Int -> Transition
dummyTransition 0 = Transition (dummyCondition 0) 5 MoveRight (dummyState 0)
dummyTransition 1 = Transition (dummyCondition 1) 3 MoveRight (dummyState 1)

dummyState :: Int -> State
dummyState 0 = Accept
dummyState 1 = Reject
dummyState 2 = State 0 [dummyTransition 0, dummyTransition 1]

dummyTape :: Tape
dummyTape = Tape [0, 0, 0, 0, 0] 0

dummyMachine :: Machine
dummyMachine =
  Machine (dummyState 2) [dummyState 0, dummyState 1, dummyState 2] dummyTape
