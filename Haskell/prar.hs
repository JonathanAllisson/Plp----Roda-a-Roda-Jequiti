import Control.Concurrent
import Control.Monad
import Data.Char
import System.IO
import System.Random

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

escrever :: String -> IO()
escrever s = do
            writeFile "sistema.txt" (s)

anexar :: String -> IO()
anexar s = do
            appendFile "sistema.txt" ("\n" ++ s)

ler :: Int -> Int -> Handle -> Int -> IO()
ler i f handle c | (i == f) = do
                            s <- hGetLine handle
                            hClose handle
                            case c of 1 -> tema (read s :: Int)
                                      2 -> sortear_numero (read s :: Int)
                 | otherwise = do
                            s <- hGetLine handle
                            ler (i+1) f handle c

ler_pontuacao :: Int -> Int -> Handle -> IO()
ler_pontuacao i f handle | (i == f) = do
                                    s1 <- hGetLine handle
                                    s2 <- hGetLine handle
                                    s3 <- hGetLine handle
                                    s4 <- hGetLine handle
                                    s5 <- hGetLine handle
                                    s6 <- hGetLine handle
                                    hClose handle
                                    pontuacao_jogadores s1 (read s2 :: Int) s3 (read s4 :: Int) s5 (read s6 :: Int)
                         | otherwise = do
                                    s <- hGetLine handle
                                    ler_pontuacao (i+1) f handle

ler_rodada :: Int -> Int -> Handle -> Int -> IO()
ler_rodada i f handle r | (i == f) = do
                            s1 <- hGetLine handle
                            s2 <- hGetLine handle
                            hClose handle
                            rodada 1 r s1 s2
                        | otherwise = do
                            s <- hGetLine handle
                            ler_rodada (i+1) f handle r

jogo :: IO()
jogo = do
    handle <- openFile "sistema.txt" ReadMode
    ler 1 1 handle 2

rodada :: Int -> Int -> String -> String -> IO()
rodada i n dica palavra | ((i-1) == n) = do
                                putStrLn("Fim")
                      | otherwise = do
                                putStrLn(">> Rodada N°: " ++ show(i))
                                handle <- openFile "sistema.txt" ReadMode
                                ler_pontuacao 1 3 handle
                                handle <- openFile "sistema.txt" ReadMode
                                ler 1 1 handle 1
                                rodada (i+1) n dica palavra


ler_rodada_aux :: Int -> IO()
ler_rodada_aux n = do
    handle <- openFile "sistema.txt" ReadMode
    tmp <- hGetLine handle
    s <- hGetLine handle
    hClose handle
    handle <- openFile "palavrasedicas.txt" ReadMode
    ler_rodada 1 n handle (read s :: Int)

sortear_numero :: Int -> IO()
sortear_numero c = do
    if (c == 1) 
        then do
            num <- randomRIO (1::Int, 20)
            if (mod num 2 == 0) then
                --putStrLn(show(num-1))
                ler_rodada_aux (num-1)
            else
                --putStrLn(show(num))
                ler_rodada_aux num
    else if (c == 2) 
        then do
            num <- randomRIO (21::Int, 40)
            if (mod num 2 == 0) then
                --putStrLn(show(num-1))
                ler_rodada_aux (num-1)
            else
                --putStrLn(show(num))
                ler_rodada_aux num
    else do
        num <- randomRIO (41::Int, 60)
        if (mod num 2 == 0) then
            --putStrLn(show(num-1))
            ler_rodada_aux (num-1)
        else
            --putStrLn(show(num))
            ler_rodada_aux num

main = do
    limpaTela
    telaInicial
    case1
    jogo
    threadDelay 2000000