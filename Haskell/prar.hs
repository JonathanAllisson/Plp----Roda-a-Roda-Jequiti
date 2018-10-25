import Control.Concurrent
import Control.Monad
import Data.Char
import System.IO

import Util

roleta = (100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, "Passou a vez", "Perdeu tudo")

limpaTela = do
    putStr "\ESC[2J"

opcaoInvalida :: Int -> IO()
opcaoInvalida x = do
    limpaTela
    opcaoInvalidaPt
    limpaTela
    case x of 1 -> case1
              2 -> case2
              3 -> case3
              4 -> case4

case4 :: IO()
case4 = do
    limpaTela
    comecar  
    nJogadores <- readLn :: IO Int
    case nJogadores of 1 -> umJogador
                       2 -> doisJogadores
                       3 -> tresJogadores
                       _ -> opcaoInvalida 4
        
case3 :: IO()
case3 = do
    limpaTela
    escolherQtdRodadas
    rodadas <- readLn :: IO Int
    if (rodadas < 1 || rodadas > 9)
        then do
            opcaoInvalida 3
    else
        do
            anexar (show(rodadas))
            case4
    
case2 :: IO()
case2 = do
    limpaTela
    escolherTema
    input <- getLine
    if (input /= "1" && input /= "2" && input /= "3")
        then do
            opcaoInvalida 2
    else
        do
            escrever (show(input))
            case3
    
case1 :: IO()
case1 = do
    limpaTela
    telaDeOpcoes
    op <- getLine
    case op of "1" -> case2
               "2" -> regras
               _ -> opcaoInvalida 1

escrever :: String -> IO()
escrever s = do
            writeFile "sistema.txt" s

anexar :: String -> IO()
anexar s = do
            appendFile "sistema.txt" ("\n" ++ s)

ler :: Int -> Int -> Handle -> IO()
ler i f handle | (i == f) = do
                            s <- hGetLine handle
                            putStrLn (s)
               | otherwise = do
                            s <- hGetLine handle
                            ler (i+1) f handle

umJogador = do
    limpaTela
    putStrLn ">> Digite seu nome: "
    n <- getLine
    anexar (n)
    anexar ("Bot 01")
    anexar ("Bot 02")
    limpaTela

doisJogadores = do
    limpaTela
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    anexar (n)
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    anexar (n2)
    anexar ("Bot 01") 
    limpaTela

tresJogadores = do
    limpaTela
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    anexar (n)
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    anexar (n2)
    putStrLn ">> Jogador 03, digite seu nome: "
    n3 <- getLine
    anexar (n3)
    limpaTela

jogo :: Int -> Int -> Int -> Int-> IO()
jogo a b c 1 = pontuacaoVencedorFinal a b c
jogo _ _ _ _= do
    print ("gsj")
    print ("gsj")

pontuacaoVencedorFinal :: Int -> Int -> Int -> IO()
pontuacaoVencedorFinal a b c = do
    let pontuacaoJogadorFinal = max (max a b) c
    print pontuacaoJogadorFinal

main = do
    limpaTela
    telaInicial
    case1
    handle <- openFile "sistema.txt" ReadMode
    ler 1 3 handle
    hClose handle