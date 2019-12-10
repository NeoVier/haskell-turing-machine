# haskell-turing-machine

This is a Turing Machine simulator, built completely in Haskell.

## Functionalities

For now, it supports deterministic single tape machines and deterministic multi tape machines.

To actually run a transition on a `Machine`, you only need to apply `transition` to a `Machine`.

### Single Tape Machines
Each `Machine` consists of a list of `State` and a `Tape`. A `Tape` is simply a list of `Int`s and an index, while a `State` has an `Id` and can be `Accept`, `Reject` or have a list of possible `Transitions`. Each `Transition` has a `Condition` (an `Int`), an `Int` (the value to be written in the current tape cell), a `Movement` (`Stay`, `MoveRight` or `MoveLeft`) and a `State`, which represents the state the machine will be on after running the transition.


### Multi Tape Machines

`MultiTape` Machines are very similar to `SingleTape` ones, being that it has pretty much the same fields. The main difference is that a `MultiTape` has states with `Multi` `Transition`s and, obviously, instead of only having one `Tape`, it has a list of `Tape`s. `Multi` `Transition`s are different from regular ones by the fact that they have a list of `Condition`s, a list of `Int`s and a list of `Movement`s, meaning that each of these fields has a value for each tape of the machine (currently, there is no guaranteeing this, as there is no checking of the amount of tapes and amount of elements on each field of the transition).

`MultiTape` machines still need better safety checking for when there's no valid transition.

## TODO

My plans are to implement:

- [WIP] multi tape machines
- a way to read some sort of code/language from a file
- run the code from a file on the right type of machine
- non-deterministic machines
