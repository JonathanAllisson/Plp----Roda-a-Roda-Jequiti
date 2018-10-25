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
    when (rodadas < 1 || rodadas > 9) $ do
        opcaoInvalida 3
    case4
    
case2 :: IO()
case2 = do
    limpaTela
    escolherTema
    input <- getLine
    when (input /= "1" && input /= "2" && input /= "3") $ do
        opcaoInvalida 2
    escrever (show(input))
    case3
    
case1 :: IO()
case1 = do
    limpaTela
    telaInicial
    limpaTela
    telaDeOpcoes
    op <- getLine
    case op of "1" -> case2
               "2" -> regras
               _ -> opcaoInvalida 1

escrever :: String -> IO()
escrever s = do
            appendFile "sistema.txt" s

umJogador = do
    limpaTela
    putStrLn ">> Digite seu nome: "
    n <- getLine
    print(n, "ainda por fazer")
    limpaTela

doisJogadores = do
    limpaTela
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    print(n,n2, "ainda por fazer") 
    limpaTela

tresJogadores = do
    limpaTela
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    putStrLn ">> Jogador 03, digite seu nome: "
    n3 <- getLine
    print(n, n2, n3, "ainda por fazer")
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
    case1