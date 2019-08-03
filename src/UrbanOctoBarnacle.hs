module UrbanOctoBarnacle where

import Graphics.Gloss
import Types


-- Rendering a square 
renderMain :: IO ()
renderMain = display (InWindow "Nice Window" (640, 480) (50, 50)) white $ renderTetris lPeice

blockSize :: Float
blockSize = 30

scaleBlock :: Int -> Float
scaleBlock = (blockSize *) . fromIntegral

renderTetris :: Tetris (Maybe Block) -> Picture
renderTetris t = Pictures $ do
  y <-  [-10..9] 
  x <-  [-10..9]
  pure $ translate (scaleBlock x) (negate $ scaleBlock y) $ 
    fromMaybe mempty $ renderBlock <$> runTetris t (XCoord x) (YCoord y)

renderBlock :: Block -> Picture
renderBlock = flip color (rectangleSolid 30 30) . blockToColor

blockToColor:: Block -> Color 
blockToColor Red   = red
blockToColor Green = green 
blockToColor Blue  = blue
