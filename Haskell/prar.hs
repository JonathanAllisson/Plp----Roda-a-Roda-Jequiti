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
    tema <- readLn :: IO Int
    if (tema < 1 || tema > 3)
        then do
            opcaoInvalida 2
    else
        do
            escrever (show(tema))
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

ler :: Int -> Int -> Handle -> Int -> IO()
ler i f handle c | (i == f) = do
                            s <- hGetLine handle
                            case c of 1 -> tema (read s :: Int)
                                      2 -> jogo 1 (read s :: Int)
                 | otherwise = do
                            s <- hGetLine handle
                            ler (i+1) f handle c

umJogador = do
    limpaTela
    putStrLn ">> Digite seu nome: "
    n <- getLine
    anexar (n)
    anexar (show(0))
    anexar ("Bot 01")
    anexar (show(0))
    anexar ("Bot 02")
    anexar (show(0))
    limpaTela

doisJogadores = do
    limpaTela
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    anexar (n)
    anexar (show(0))
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    anexar (n2)
    anexar (show(0))
    anexar ("Bot 01") 
    anexar (show(0))
    limpaTela

tresJogadores = do
    limpaTela
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    anexar (n)
    anexar (show(0))
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    anexar (n2)
    anexar (show(0))
    putStrLn ">> Jogador 03, digite seu nome: "
    n3 <- getLine
    anexar (n3)
    anexar (show(0))
    limpaTela

jogo :: Int -> Int -> IO()
jogo i n | ((i-1) == n) = do
                putStrLn("Fim")
         | otherwise = do
                putStrLn(">> Rodada N°: " ++ show(i))
                handle <- openFile "sistema.txt" ReadMode
                ler 1 1 handle 1
                hClose handle
                jogo (i+1) n

main = do
    limpaTela
    telaInicial
    case1
    handle <- openFile "sistema.txt" ReadMode
    ler 1 2 handle 2
    hClose handle
    threadDelay 2000000