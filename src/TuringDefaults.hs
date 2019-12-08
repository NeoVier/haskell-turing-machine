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

type Condition = Int -> Bool

data Movement
  = Stay
  | MoveRight
  | MoveLeft
  deriving (Show)

data Transition =
  Transition
    { condition :: Condition
    , newValue :: Int
    , movement :: Movement
    , endState :: State
    }

instance Show Transition where
  show (Transition condition newValue move endState) =
    "Transition " ++ show newValue ++ " " ++ show move ++ " " ++ show endState

data Machine =
  SingleTape
    { currentState :: State
    , states :: [State]
    , machineTape :: Tape
    }
  deriving (Show)

move :: Tape -> Movement -> Tape
move tape Stay = tape
move (Tape inputTape tapeIndex) MoveLeft = Tape inputTape (tapeIndex - 1)
move (Tape inputTape tapeIndex) MoveRight = Tape inputTape (tapeIndex + 1)

pickTransition :: [Transition] -> Tape -> Transition
pickTransition [] _ = error "TuringMachine.pickTransition: No valid transitions"
pickTransition (x:xs) inputTape
  | condition x (currValue inputTape) = x
  | otherwise = pickTransition xs inputTape

currValue :: Tape -> Int
currValue (Tape inputTape tapeIndex) = inputTape !! tapeIndex

replaceValue :: Tape -> Int -> Tape
replaceValue (Tape inputTape tapeIndex) newValue =
  Tape (replaceNth tapeIndex inputTape newValue) tapeIndex

replaceNth :: Int -> [a] -> a -> [a]
replaceNth 0 (x:xs) newValue = newValue : xs
replaceNth n (x:xs) newValue = x : replaceNth (n - 1) xs newValue
