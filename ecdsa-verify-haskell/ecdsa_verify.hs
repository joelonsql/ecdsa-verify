{-# LANGUAGE FlexibleContexts #-}

import System.Environment (getArgs)
import Data.Maybe (fromMaybe)
import Data.Word (Word8)
import Numeric (readHex,showHex)
import System.Exit (exitSuccess,exitFailure)

modularInverse :: (Integral a, Ord a) => a -> a -> Maybe a
modularInverse a n
  | n == 0 || n == 1 = Nothing
  | otherwise =
    let (t, newt) = (0, 1)
        (r, newr) = (n, a)
    in loop t newt r newr
  where
    loop t newt r newr
      | newr == 0 =
        if r > 1
          then Nothing
          else Just $ if t < 0 then t + n else t
      | otherwise =
        let quotient = r `div` newr
        in loop newt (t - quotient * newt) newr (r - quotient * newr)

main :: IO ()
main = do
  tests
  args <- getArgs
  if length args /= 2
    then do
      putStrLn "Expected two hexadecimal strings as arguments"
      exitSuccess
    else return ()
  [aHex, nHex] <- getArgs
  let a = fromIntegral $ fst $ head $ readHex aHex
      n = fromIntegral $ fst $ head $ readHex nHex
  putStrLn $
    case modularInverse a n of
      Just x -> showHex x ""
      Nothing -> "No inverse exists for the given values"

tests :: IO ()
tests = do
  let a = fromIntegral $ fst $ head $ readHex "69c6e9f8d9bcbdba4e5478cb75b084332d51b0be2c21701b157c7c87abb98057"
      n = fromIntegral $ fst $ head $ readHex "fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141"
      expectedResult = Just $ fromIntegral $ fst $ head $ readHex "321e5faa4b27bb008db179136e9c4ecf781542f425541ea27ecdf6236cb776b0"
  assertEqual "testModularInverse" (modularInverse a n) expectedResult
  assertEqual "testModularNoInverse" (modularInverse 4 6) Nothing
  assertEqual "testModularNoInverse2" (modularInverse 4 0) Nothing
  assertEqual "testModularNoInverse3" (modularInverse 4 1) Nothing
  where
    assertEqual :: (Eq a, Show a) => String -> a -> a -> IO ()
    assertEqual name expected actual =
      if expected /= actual
        then do
          putStrLn $ name ++ ": Failed (" ++ show expected ++ " /= " ++ show actual ++ ")"
          exitFailure
        else return ()
