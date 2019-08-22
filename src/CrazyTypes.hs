{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE DerivingVia                #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module CrazyTypes where

import Prelude hiding (rotate, Last (..))
import Data.Monoid (Last (..))
import Control.Comonad.Store
import Types (XCoord(..), YCoord(..))

type Tetris = Store (XCoord, YCoord)

goUp :: Tetris a -> Tetris a
goUp = peeks $ second (<> YCoord (-1))

runGravity :: Tetris a -> Tetris a
runGravity = extend . const $ extract . goUp 

