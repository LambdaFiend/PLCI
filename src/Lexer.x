{
module Lexer where
}

%wrapper "posn"

$white    = [\ \t\n\r\b]
$lower    = [a-z]
$upper    = [A-Z]
$digit    = [0-9]
$alpha    = [a-zA-Z]
$alphanum = [a-zA-Z0-9]

tokens :-

$white+      ;
\\|"λ"       { \pos _ -> Token pos LAMBDA }
"."          { \pos _ -> Token pos DOT }
"("          { \pos _ -> Token pos LPAREN }
")"          { \pos _ -> Token pos RPAREN }
$lower+"\'"* { \pos s -> Token pos $ ID s }
.            { \pos s -> Token pos $ ERROR ("Lexing error: " ++ s) }

{
data Token = Token
  { tokenPos :: AlexPosn
  , tokenDat :: TokenData
  }
  deriving (Show, Eq)

data TokenData
  = ERROR String
  | LAMBDA
  | DOT
  | LPAREN
  | RPAREN
  | ID String
  deriving (Show, Eq)
}
