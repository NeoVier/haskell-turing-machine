module TuringMachines
  ( transition
  ) where

import TuringDefaults

transition :: Machine -> Machine
-- Single tape transition
transition (SingleTape (Accept x) others inputTape) =
  SingleTape (Accept x) others inputTape
transition (SingleTape (Reject x) others inputTape) =
  SingleTape (Reject x) others inputTape
transition (SingleTape currState others inputTape) =
  SingleTape newState others newTape
  where
    (Single _ writeValue moveTo newState) =
      pickTransition (SingleTape currState others inputTape)
    newTape = move (replaceValue inputTape writeValue) moveTo
-- Multi tape transition
transition (MultiTape (Accept x) others inputTapes) =
  MultiTape (Accept x) others inputTapes
transition (MultiTape (Reject x) others inputTapes) =
  MultiTape (Reject x) others inputTapes
transition (MultiTape currState others inputTapes) =
  MultiTape newState others newTapes
  where
    (Multi _ writeValues moves newState) =
      pickTransition (MultiTape currState others inputTapes)
    replacedTapes = zipWith replaceValue inputTapes writeValues
    newTapes = zipWith move replacedTapes moves
