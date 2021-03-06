module Parser where

import           Control.Applicative
import           Data.Bifunctor
import           Data.Char
import           Data.Tuple

newtype Parser a = Parser { runParser :: String -> Maybe (String, a) }

instance Functor Parser where
  fmap f (Parser p) = Parser $ fmap (second f) . p

instance Applicative Parser where
  pure a = Parser $ \x -> Just (x, a)
  (Parser p1) <*> (Parser p2) = Parser $ \input -> do
    (input', f) <- p1 input
    (input'', b) <- p2 input'
    return (input'', f b)

instance Alternative Parser where
  empty = Parser $ const Nothing
  (Parser p1) <|> (Parser p2) = Parser $ \input ->
    p1 input <|> p2 input

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
charP c = ifP  (== c)
