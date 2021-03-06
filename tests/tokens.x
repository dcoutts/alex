{
module Main (main) where
import System.Exit
}

%wrapper "basic"

$digit = 0-9			-- digits
$alpha = [a-zA-Z]		-- alphabetic characters

tokens :-

  $white+				;
  "--".*				;
  let					{ \s -> Let }
  in					{ \s -> In }
  $digit+				{ \s -> Int (read s) }
  [\=\+\-\*\/\(\)]			{ \s -> Sym (head s) }
  $alpha [$alpha $digit \_ \']*		{ \s -> Var s }

{
-- Each right-hand side has type :: String -> Token

-- The token type:
data Token =
	Let 		|
	In  		|
	Sym Char	|
	Var String	|
	Int Int		|
	Err 
	deriving (Eq,Show)

main = if test1 /= result1 then exitFailure
			   else exitWith ExitSuccess

test1 = alexScanTokens "  let in 012334\n=+*foo bar__'"
result1 = [Let,In,Int 12334,Sym '=',Sym '+',Sym '*',Var "foo",Var "bar__'"]

}
