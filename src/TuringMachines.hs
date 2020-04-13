module TuringMachines
  ( transition
  ) where

import TuringDefaults

transition :: Machine -> Machine
-- Single tape transition
transition (SingleTape state others inputTape)
  | isFinal state = SingleTape state others inputTape
  | otherwise = SingleTape newState others newTape
  where
    (Single _ writeValue moveTo newState) =
      pickTransition (SingleTape state others inputTape)
    newTape = move (replaceValue inputTape writeValue) moveTo
-- Multi tape transition
transition (MultiTape state others inputTapes)
  | isFinal state = MultiTape state others inputTapes
  | otherwise = MultiTape newState others newTapes
  where
    (Multi _ writeValues moves newState) =
      pickTransition (MultiTape state others inputTapes)
    replacedTapes = zipWith replaceValue inputTapes writeValues
    newTapes = zipWith move replacedTapes moves
