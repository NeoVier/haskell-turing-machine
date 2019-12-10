module TuringDefaults
  ( Tape(..)
  , Id
  , State(..)
  , Condition
  , Movement(..)
  , Transition(..)
  , Machine(..)
  , move
  , pickTransition
  , currValue
  , replaceValue
  ) where

data Tape =
  Tape
    { tape :: [Int]
    , index :: Int
    }
  deriving (Show)

type Id = Int

data State
  = State
      { id :: Id
      , transitions :: [Transition]
      }
  | Accept
      { id :: Id
      }
  | Reject
      { id :: Id
      }
  deriving (Show)

type Condition = Int

data Movement
  = Stay
  | MoveRight
  | MoveLeft
  deriving (Show)

data Transition
  = Single
      { condition :: Condition
      , newValue :: Int
      , movement :: Movement
      , endState :: State
      }
  | Multi
      { conditions :: [Condition]
      , newValues :: [Int]
      , movements :: [Movement]
      , endState :: State
      }
  deriving (Show)

data Machine
  = SingleTape
      { currentState :: State
      , states :: [State]
      , machineTape :: Tape
      }
  | MultiTape
      { currentState :: State
      , states :: [State]
      , machineTapes :: [Tape]
      }
  deriving (Show)

move :: Tape -> Movement -> Tape
move tape Stay = tape
move (Tape inputTape tapeIndex) MoveLeft
  | tapeIndex == 0 = error "TuringDefaults.move: Negative index."
  | otherwise = Tape inputTape (tapeIndex - 1)
move (Tape inputTape tapeIndex) MoveRight = Tape inputTape (tapeIndex + 1)

pickTransition :: Machine -> Transition
pickTransition (SingleTape currState others inputTape)
  | null possibleTransitions =
    error "TuringDefaults.pickTransition: No valid transition."
  | otherwise = pickFromPossibles possibleTransitions
  where
    possibleTransitions = transitions currState
    pickFromPossibles (x:xs)
      | condition x == currValue inputTape = x
      | otherwise = pickFromPossibles xs
pickTransition (MultiTape currState others inputTapes)
  | null possibleTransitions =
    error "TuringDefaults.pickTransition: No valid transition."
  | otherwise = pickFromPossibles
  where
    possibleTransitions = transitions currState
    bytes = map currValue inputTapes
    validTransitions =
      dropWhile
        (elem False . zipWith (==) bytes . conditions)
        possibleTransitions
    pickFromPossibles = head validTransitions

currValue :: Tape -> Int
currValue (Tape inputTape tapeIndex) = inputTape !! tapeIndex

replaceValue :: Tape -> Int -> Tape
replaceValue (Tape inputTape tapeIndex) newValue =
  Tape (replaceNth tapeIndex inputTape newValue) tapeIndex

replaceNth :: Int -> [a] -> a -> [a]
replaceNth 0 (x:xs) newValue = newValue : xs
replaceNth n (x:xs) newValue = x : replaceNth (n - 1) xs newValue
