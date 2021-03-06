module Testing
  ( dummyCondition
  , dummyTransition
  , dummyState
  , dummyTape
  , dummyMachine
  ) where

import TuringDefaults
import TuringMachines

dummyCondition :: Int -> Condition
dummyCondition 0 = 0
dummyCondition 1 = 3

dummyTransition :: Int -> Transition
dummyTransition 0 = Single (dummyCondition 0) 5 MoveRight (dummyState 0)
dummyTransition 1 = Single (dummyCondition 1) 3 MoveRight (dummyState 1)
dummyTransition 2 =
  Multi
    [dummyCondition 0, dummyCondition 0]
    [10, 100]
    [MoveRight, MoveRight]
    (dummyState 1)

dummyState :: Int -> State
dummyState 0 = Accept 0
dummyState 1 = Reject 1
dummyState 2 = State 2 [dummyTransition 0, dummyTransition 1]
dummyState 3 = State 3 [dummyTransition 2]

dummyTape :: Tape
dummyTape = Tape [0, 0, 0, 0, 0] 0

dummyMachine :: Int -> Machine
dummyMachine 0 =
  SingleTape (dummyState 2) [dummyState 0, dummyState 1, dummyState 2] dummyTape
dummyMachine 1 =
  MultiTape
    (dummyState 3)
    [dummyState 0, dummyState 1, dummyState 3]
    [dummyTape, dummyTape]
