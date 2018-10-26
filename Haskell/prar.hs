import Control.Concurrent
import Control.Monad
import Data.Char
import System.IO
import System.Random
import System.Console.ANSI

import Util

roleta = (100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, "Passou a vez", "Perdeu tudo")

opcaoInvalida :: Int -> Int -> Int -> IO()
opcaoInvalida x tem rod = do
    clearScreen
    opcaoInvalidaPt
    clearScreen
    case x of 1 -> case1
              2 -> case2
              3 -> case3 tem
              4 -> case4 tem rod

case4 :: Int -> Int -> IO()
case4 tem rod= do
    clearScreen
    comecar  
    nJogadores <- readLn :: IO Int
    case nJogadores of 1 -> umJogador tem rod
                       2 -> doisJogadores tem rod
                       3 -> tresJogadores tem rod
                       _ -> opcaoInvalida 4 tem rod
        
case3 :: Int -> IO()
case3 tem = do
    clearScreen
    escolherQtdRodadas
    rod <- readLn :: IO Int
    if (rod < 1 || rod > 9)
        then do
            opcaoInvalida 3 tem 0
    else
        do
            case4 tem rod
    
case2 :: IO()
case2 = do
    clearScreen
    escolherTema
    tem <- readLn :: IO Int
    if (tem < 1 || tem > 3)
        then do
            opcaoInvalida 2 0 0
    else
        do
            case3 tem
    
case1 :: IO()
case1 = do
    clearScreen
    telaDeOpcoes
    op <- getLine
    case op of "1" -> case2
               "2" -> regras
               _ -> opcaoInvalida 1 0 0

umJogador :: Int -> Int -> IO()
umJogador tem rod = do
    clearScreen
    putStrLn ">> Digite seu nome: "
    n <- getLine
    escrever (n)
    anexar (show(0))
    anexar ("Bot 01")
    anexar (show(0))
    anexar ("Bot 02")
    anexar (show(0))
    clearScreen
    jogo tem rod

doisJogadores :: Int -> Int -> IO()
doisJogadores tem rod = do
    clearScreen
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    escrever (n)
    anexar (show(0))
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    anexar (n2)
    anexar (show(0))
    anexar ("Bot 01") 
    anexar (show(0))
    clearScreen
    jogo tem rod

tresJogadores :: Int -> Int -> IO()
tresJogadores tem rod = do
    clearScreen
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    escrever (n)
    anexar (show(0))
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    anexar (n2)
    anexar (show(0))
    putStrLn ">> Jogador 03, digite seu nome: "
    n3 <- getLine
    anexar (n3)
    anexar (show(0))
    clearScreen
    jogo tem rod

escrever :: String -> IO()
escrever s = do
    writeFile "sistema.txt" (s)

anexar :: String -> IO()
anexar s = do
    appendFile "sistema.txt" ("\n" ++ s)

ler_pontuacao :: Int -> Int -> Handle -> IO()
ler_pontuacao i f handle  = do
        s1 <- hGetLine handle
        s2 <- hGetLine handle
        s3 <- hGetLine handle
        s4 <- hGetLine handle
        s5 <- hGetLine handle
        s6 <- hGetLine handle
        hClose handle
        pontuacao_jogadores s1 (read s2 :: Int) s3 (read s4 :: Int) s5 (read s6 :: Int)

ler_rodada :: Int -> Int -> Handle -> Int -> Int -> Int -> IO()
ler_rodada i f handle n tem rod
    | (i == f) = do
        s1 <- hGetLine handle
        s2 <- hGetLine handle
        hClose handle
        rodadas n s1 s2 tem rod
    | otherwise = do
        s <- hGetLine handle
        ler_rodada (i+1) f handle n tem rod

jogo :: Int -> Int -> IO()
jogo tem rod = do
    sortear_numero 1 tem rod

sortear_numero :: Int -> Int -> Int-> IO()
sortear_numero n tem rod = do
    handle <- openFile "palavrasedicas.txt" ReadMode
    if (tem == 1) 
        then do
            num <- randomRIO (1::Int, 20)
            if (mod num 2 == 0) then
                ler_rodada 1 (num-1) handle n tem rod
            else
                ler_rodada 1 num handle n tem rod
    else if (tem == 2) 
        then do
            num <- randomRIO (21::Int, 40)
            if (mod num 2 == 0) then
                ler_rodada 1 (num-1) handle n tem rod
            else
                ler_rodada 1 num handle n tem rod
    else do
        num <- randomRIO (41::Int, 60)
        if (mod num 2 == 0) then
            ler_rodada 1 (num-1) handle n tem rod
        else
            ler_rodada 1 num handle n tem rod

rodadas :: Int -> String -> String -> Int -> Int -> IO()
rodadas n dica palavra tem rod
    | (((rod + 1) - n) == 0) = do
        putStrLn("Fim")
    | otherwise = do
        rodada n dica palavra (cobrir_palavra (length palavra)) "" tem rod
        sortear_numero (n+1) tem rod

rodada :: Int -> String -> String -> String -> String -> Int -> Int -> IO()
rodada n dica palavra coberta escolhidas tem rod
    | ((qnt_coberta coberta) == 0) = do
        putStrLn("xi")
    | ((qnt_coberta coberta) < 4) = do
        putStrLn("eita")
    | otherwise = do
        putStrLn(">> Rodada N°: " ++ show(n))
        handle <- openFile "sistema.txt" ReadMode
        ler_pontuacao 1 3 handle
        tema tem
        putStrLn("Dica: " ++ dica)
        putStrLn("Palavra: " ++ coberta ++ " ||| " ++ palavra)
        putStrLn("Letra(s) já escolhida(s): " ++ escolhidas)
        putStrLn(">> Digite uma letra: ")
        le <- getLine
        if (existe_letra escolhidas (toUpper (head le))) then do
            clearScreen
            letraEscolhida
            clearScreen
            rodada n dica palavra coberta escolhidas tem rod
        else do
            clearScreen
            rodada n dica palavra (descobrir_letra palavra coberta (toUpper (head le))) (escolhidas ++ [(toUpper (head le))] ++ " ") tem rod

existe_letra :: String -> Char -> Bool
existe_letra [] _ = False
existe_letra (x:xs) y | (x == y) = True
                      | otherwise = existe_letra xs y

qnt_coberta :: String -> Int
qnt_coberta [] = 0
qnt_coberta (x:xs) | (x == '#') = 1 + qnt_coberta xs
                   | otherwise = qnt_coberta xs

descobrir_letra :: String -> String -> Char -> String
descobrir_letra [] [] le = []
descobrir_letra (x:xs) (y:ys) le | (x == le) = [x] ++ descobrir_letra xs ys le
                                 | otherwise = [y] ++ descobrir_letra xs ys le

cobrir_palavra :: Int -> String
cobrir_palavra 0 = []
cobrir_palavra n = "#" ++ cobrir_palavra (n-1)

main = do
    clearScreen
    telaInicial
    case1
    threadDelay 2000000