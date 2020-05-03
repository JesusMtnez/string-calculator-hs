module Parser where

import           Data.Char
import           Data.Bifunctor
import           Data.Tuple
import           Control.Applicative

newtype Parser a = Parser { runParser :: String -> Maybe (String, a) }

instance Functor Parser where
  fmap f (Parser p) = Parser $ fmap (second f) . p

-- instance Applicative Parser where

-- instance Alternative Parser where

stringCalculatorParser :: Parser [Int]
stringCalculatorParser = undefined

literalP :: String -> Parser String
literalP l = undefined

andThenP :: Parser a -> (a -> Parser [b]) -> Parser [b]
andThenP p f = undefined

digitP :: Parser Char
digitP = ifP isDigit

spanP :: (Char -> Bool) -> Parser String
spanP = undefined

ifP :: (Char -> Bool) -> Parser Char
ifP g = Parser f
  where
    f :: String -> Maybe (String, Char)
    f [] =  Nothing
    f (x : xs) | g x = Just (xs, x)
               | otherwise = Nothing

sepBy :: Parser a -> Parser b -> Parser [b]
sepBy p1 p2 = undefined

charP :: Char -> Parser Char
charP c = Parser f
  where
    f :: String -> Maybe (String, Char)
    f [] =  Nothing
    f (x : xs) | x == c = Just (xs, x)
               | otherwise = Nothing

-- ifP (_ == c)
