{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE DerivingVia                #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Types where

import Prelude hiding (rotate, Last (..))
import Data.Monoid (Last (..))


newtype Tetris a = Tetris
  { runTetris' :: (XCoord, YCoord) -> a
  } deriving (Functor, Applicative, Monad, Monoid, Semigroup)

tetris :: (XCoord -> YCoord -> a) -> Tetris a
tetris = Tetris . uncurry

runTetris :: Tetris a -> XCoord -> YCoord -> a
runTetris = curry . runTetris'

newtype XCoord = XCoord Int
  deriving stock (Eq, Ord, Show)
  deriving (Semigroup, Monoid) via Sum Int

newtype YCoord = YCoord Int
  deriving stock (Eq, Ord, Show)
  deriving (Semigroup, Monoid) via Sum Int

data Block
  = Red
  | Green
  | Blue
  deriving (Eq, Ord, Enum)

instance Show Block where
  show Red   = "R"
  show Green = "G"
  show Blue  = "B"


emptyBoard :: Tetris (Maybe Block)
emptyBoard = pure Nothing

appendBoard :: Monoid a => Tetris a -> Tetris a -> Tetris a
appendBoard = mappend

move :: XCoord -> YCoord -> Tetris a -> Tetris a
move dx dy piece = Tetris $ \(x, y) ->
  runTetris piece (dx <> x) (dy <> y)

rotate :: Tetris a -> Tetris a
rotate piece = Tetris $ \(XCoord x, YCoord y) ->
  runTetris piece (XCoord $ -y) $ YCoord x

mkBlock :: a -> XCoord -> YCoord -> Tetris (Maybe a)
mkBlock a x y = tetris $ \x' y' ->
  if x == x' && y == y'
     then Just a
     else Nothing

mkPiece :: a -> [(Int, Int)] -> Tetris (Maybe a)
mkPiece a =
  fmap getLast . foldMap ( fmap Last
                         . uncurry (mkBlock a)
                         . (XCoord *** YCoord)
                         )

lPeice :: Tetris (Maybe Block)
lPeice =
  mkPiece Green
    [ (0, 0)
    , (1, 0)
    , (0, -1)
    , (0, -2)
    ]


showTetris :: Show a => Tetris (Maybe a) -> String
showTetris t = unlines . fmap join . fmap (fmap (maybe " "  show)) $ do
  y <- fmap YCoord [-10..9]
  pure $ do
    x <- fmap XCoord [-10..9]
    pure $ runTetris t x y



