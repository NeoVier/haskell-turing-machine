# haskell-turing-machine

This is a Turing Machine simulator, built completely in Haskell.

## Functionalities

For now, it only supports deterministic single tape machines.

Each `Machine` consists of a list of `State` and a `Tape`. A `Tape` is simply a list of `Int`s and an index, while a `State` can be `Accept`, `Reject` or consist of an `Id` and a list of possible `Transitions`. Each `Transition` has a `Condition` (a function `(Int -> Bool)`), an `Int` (the value to be written in the current tape cell), a `Movement` (`Stay`, `MoveRight` or `MoveLeft`) and a `State`, which represents the state the machine will be on after running the transition.

To actually run a transition on a `Machine`, you only need to apply `transition` to a `Machine`.

## TODO

My plans are to implement:

- multi tape machines
- a way to read some sort of code/language from a file
- run the code from the file on the machine
- non-deterministic machines
