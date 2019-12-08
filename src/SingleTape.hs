module SingleTape
  ( transition
  ) where

import TuringDefaults

transition :: Machine -> Machine
transition (SingleTape (Accept x) others inputTape) =
  SingleTape (Accept x) others inputTape
transition (SingleTape (Reject x) others inputTape) =
  SingleTape (Reject x) others inputTape
transition (SingleTape currState others inputTape) =
  SingleTape newState others newTape
  where
    (Transition _ writeValue moveTo newState) =
      pickTransition (transitions currState) inputTape
    newTape = move (replaceValue inputTape writeValue) moveTo
