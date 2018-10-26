import Control.Concurrent
import Control.Monad
import Data.Char
import System.IO
import System.Random
import System.Console.ANSI
import System.IO.Unsafe

import Util

type Pessoa = String
type Pontuacao = Int
type Jogador = (Pessoa, Pontuacao)
type Jogadores = [Jogador]

roleta = ["100", "150", "200", "250", "Passou a vez", "300", "350", "400", "450", "500", "550", "Passou a vez", "600", "650", "700", "750", "Perdeu tudo", "800", "850", "900", "950", "1000", "Passou a vez", "Perdeu tudo"]
letras = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "X", "Y", "Z"]
bot = ["True", "False"]

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
    if (rod < 1 || rod > 10)
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
    if (op == "1") then do
        case2
    else if (op == "2") then do
        regras
        case1
    else do
        opcaoInvalida 1 0 0

umJogador :: Int -> Int -> IO()
umJogador tem rod = do
    clearScreen
    putStrLn ">> Digite seu nome: "
    n <- getLine
    clearScreen
    jogo tem rod [(n, 0), ("Bot 01", 0), ("Bot 02", 0)]

doisJogadores :: Int -> Int -> IO()
doisJogadores tem rod = do
    clearScreen
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    clearScreen
    jogo tem rod [(n, 0), (n2, 0), ("Bot 01", 0)]

tresJogadores :: Int -> Int -> IO()
tresJogadores tem rod = do
    clearScreen
    putStrLn ">> Jogador 01, digite seu nome: "
    n <- getLine
    putStrLn ">> Jogador 02, digite seu nome: "
    n2 <- getLine
    putStrLn ">> Jogador 03, digite seu nome: "
    n3 <- getLine
    clearScreen
    jogo tem rod [(n, 0), (n2, 0), (n3, 0)]

ler_rodada :: Int -> Int -> Int -> Handle -> Int -> Int -> Int -> Jogadores -> IO()
ler_rodada z i f handle n tem rod jogas
    | (i == f) = do
        s1 <- hGetLine handle
        s2 <- hGetLine handle
        hClose handle
        rodadas z n s1 s2 tem rod jogas [((pegar_nome jogas 1 1), 0), ((pegar_nome jogas 1 2), 0), ((pegar_nome jogas 1 3), 0)]
    | otherwise = do
        s <- hGetLine handle
        ler_rodada z (i+1) f handle n tem rod jogas

jogo :: Int -> Int -> Jogadores -> IO()
jogo tem rod jogas = do
    sortear_numero 1 1 tem rod jogas

sortear_numero :: Int -> Int -> Int -> Int -> Jogadores -> IO()
sortear_numero z n tem rod jogas = do
    handle <- openFile "palavrasedicas.txt" ReadMode
    if (tem == 1) 
        then do
            num <- randomRIO (1::Int, 40)
            if (mod num 2 == 0) then
                ler_rodada z 1 (num-1) handle n tem rod jogas
            else
                ler_rodada z 1 num handle n tem rod jogas
    else if (tem == 2) 
        then do
            num <- randomRIO (41::Int, 80)
            if (mod num 2 == 0) then
                ler_rodada z 1 (num-1) handle n tem rod jogas
            else
                ler_rodada z 1 num handle n tem rod jogas
    else do
        num <- randomRIO (81::Int, 120)
        if (mod num 2 == 0) then
            ler_rodada z 1 (num-1) handle n tem rod jogas
        else
            ler_rodada z 1 num handle n tem rod jogas

pegar_nome :: Jogadores -> Int -> Int -> String
pegar_nome [(y, _)] i n = y
pegar_nome ((y, _):xs) i n | (n == i) = y
                           | otherwise = pegar_nome xs (i+1) n

pegar_pontuacao :: Jogadores -> Int -> Int -> Int
pegar_pontuacao [(_, y)] i n = y
pegar_pontuacao ((_, y):xs) i n | (n == i) = y
                                | otherwise = pegar_pontuacao xs (i+1) n

sortear_numero_roleta :: Int -> Int -> Int
sortear_numero_roleta a b = unsafePerformIO(randomRIO (a::Int, b))

pegar_item :: Int -> Int -> [String] -> String
pegar_item i n (x:xs) | (i == n) = x
                        | otherwise = pegar_item (i+1) n xs

pegar_numero :: -> Jogadores -> Int -> Int -> Int
pegar_numero [(_, y)] = i
pegar_numero [(_, y):xs] i n | (y == n) = i
                             | otherwise = pegar_numero xs (i+1) n

rodadas :: Int -> Int -> String -> String -> Int -> Int -> Jogadores -> Jogadores -> IO()
rodadas z n dica palavra tem rod jogas jogasT
    | (((rod + 1) - n) == 0) = do
        clearScreen
        pontuacao_jogadores_geral (pegar_nome jogas 1 1) (pegar_pontuacao jogas 1 1) (pegar_nome jogas 1 2) (pegar_pontuacao jogas 1 2) (pegar_nome jogas 1 3) (pegar_pontuacao jogas 1 3)
        threadDelay 2000000
        clearScreen
        let z = maximum [(pegar_pontuacao jogas 1 1), (pegar_pontuacao jogas 1 2), (pegar_pontuacao jogas 1 3)]
        let sortea = (sortear_numero_roleta 1 24)
        let coberta = cobrir_palavra palavra
        putStrLn("Parabéns: " ++ (pegar_nome jogas 1 (pegar_numero jogas 1 z)) ++ " você chegou na rodada final")
        threadDelay 2000000
        clearScreen
        if((pegar_nome jogas 1 (pegar_numero jogas 1 z)) == "Bot 01" || (pegar_nome jogas 1 (pegar_numero jogas 1 z)) == "Bot 02") then do
            let kl = (read (pegar_item 1 2 bot) :: Bool)
            if(kl) then do
                putStrLn("Parabéns, " ++ (pegar_nome jogas 1 (pegar_numero jogas 1 z)) ++ " GANHOU!")
                threadDelay 2000000
            else do
                putStrLn("Que pena, " ++ (pegar_nome jogas 1 (pegar_numero jogas 1 z)) ++ " perdeu...")
                threadDelay 2000000
        else do
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            putStrLn("Palavra: " ++ coberta ++ " ||| " ++ palavra)
            putStrLn("Girando a roleta...")
            let rol = pegar_item 1 (sortea) roleta
            threadDelay 2000000
            putStrLn("Valendo " ++ rol ++ " pontos por letra, digite uma vogal e 4 consoantes.")
            putStrLn("Letras já escolhidas: ")
            v <- getLine
            let lje1 = [v] ++ " "
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            putStrLn("Palavra: " ++ coberta ++ " ||| " ++ palavra)
            putStrLn("Valendo " ++ rol ++ " pontos por letra, digite uma vogal e 4 consoantes.")
            putStrLn("Letras já escolhidas: " ++ lje1)
            c1 <- getLine
            let lje2 = lje1 ++ [c1] ++ " "
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            putStrLn("Palavra: " ++ coberta ++ " ||| " ++ palavra)
            putStrLn("Valendo " ++ rol ++ " pontos por letra, digite uma vogal e 4 consoantes.")
            putStrLn("Letras já escolhidas: " ++ lje2)
            c2 <- getLine
            let lje3 = lje2 ++ [c2] ++ " "
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            putStrLn("Palavra: " ++ coberta ++ " ||| " ++ palavra)
            putStrLn("Valendo " ++ rol ++ " pontos por letra, digite uma vogal e 4 consoantes.")
            putStrLn("Letras já escolhidas: " ++ lje3)
            c3 <- getLine
            let lje4 = lje3 ++ [c3] ++ " "
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            putStrLn("Palavra: " ++ coberta ++ " ||| " ++ palavra)
            putStrLn("Valendo " ++ rol ++ " pontos por letra, digite uma vogal e 4 consoantes.")
            putStrLn("Letras já escolhidas: " ++ lje4)
            c4 <- getLine
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            let cob1 = (descobrir_letra palavra coberta v)
            putStrLn("Palavra: " ++ cob1 ++ " ||| " ++ palavra)
            threadDelay 2000000
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            let cob2 = (descobrir_letra palavra cob1 c1)
            putStrLn("Palavra: " ++ cob2 ++ " ||| " ++ palavra)
            threadDelay 2000000
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            let cob3 = (descobrir_letra palavra cob2 c2)
            putStrLn("Palavra: " ++ cob3 ++ " ||| " ++ palavra)
            threadDelay 2000000
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            let cob4 = (descobrir_letra palavra cob3 c3)
            putStrLn("Palavra: " ++ cob4 ++ " ||| " ++ palavra)
            threadDelay 2000000
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            let cob5 = (descobrir_letra palavra cob4 c4)
            putStrLn("Palavra: " ++ cob5 ++ " ||| " ++ palavra)
            threadDelay 2000000
            clearScreen
            putStrLn(">> Rodada Final:")
            putStrLn("Dica: " ++ dica)
            putStrLn("Palavra: " ++ cob5 ++ " ||| " ++ palavra)
            putStrLn("Por favor, digite a palavra corretamente para ganhar 1 MILHÃO DE REAIS!!!")
            pl <- getLine
            if (palavra_correta pl palavra) then do
                putStrLn "***********************************************************************"
                putStrLn "************ PARABÉNS, VOCÊ GANHOU 1 MILHÃO DE REAIS ******************"
                putStrLn "***********************************************************************"
                threadDelay 3000000
            else do
                putStrLn("Você perdeu...")
                threadDelay 3000000
    | otherwise = do
        clearScreen
        rodada z n dica palavra (cobrir_palavra palavra) "" tem rod jogas jogasT (sortear_numero_roleta 1 24)

rodada :: Int -> Int -> String -> String -> String -> String -> Int -> Int -> Jogadores -> Jogadores -> Int -> IO()
rodada i n dica palavra coberta escolhidas tem rod jogas jogasT sortea
    | ((qnt_coberta coberta) == 0) = do
        clearScreen
        let z = if (i > 3) then 1 else i
        putStrLn(">> Parabéns " ++ (pegar_nome jogasT 1 z) ++ " você acertou!")
        threadDelay 2000000
        pontuacao_jogadores_geral (pegar_nome jogas 1 1) ((pegar_pontuacao jogas 1 1) + (pegar_pontuacao jogasT 1 1)) (pegar_nome jogas 1 2) ((pegar_pontuacao jogas 1 2) + (pegar_pontuacao jogasT 1 2)) (pegar_nome jogas 1 3) ((pegar_pontuacao jogas 1 3) + (pegar_pontuacao jogasT 1 3))
        sortear_numero z (n+1) tem rod [((pegar_nome jogas 1 1), ((pegar_pontuacao jogas 1 1) + (pegar_pontuacao jogasT 1 1))), ((pegar_nome jogas 1 2), ((pegar_pontuacao jogas 1 2) + (pegar_pontuacao jogasT 1 2))), ((pegar_nome jogas 1 3), ((pegar_pontuacao jogas 1 3) + (pegar_pontuacao jogasT 1 3)))]
    | ((qnt_coberta coberta) < 4) = do
        let z = if (i > 3) then 1 else i
        putStrLn(">> Rodada N°: " ++ show(n))
        pontuacao_jogadores (pegar_nome jogasT 1 1) (pegar_pontuacao jogasT 1 1) (pegar_nome jogasT 1 2) (pegar_pontuacao jogasT 1 2) (pegar_nome jogasT 1 3) (pegar_pontuacao jogasT 1 3)
        tema tem
        putStrLn("Dica: " ++ dica)
        putStrLn("Palavra: " ++ coberta ++ " ||| " ++ palavra)
        putStrLn("Letra(s) já escolhida(s): " ++ escolhidas)
        putStrLn("Girando a roleta...")
        let rol = pegar_item 1 (sortea) roleta
        threadDelay 2000000
        if (rol == "Perdeu tudo") then do
            putStrLn(">> Perdeu tudo...")
            threadDelay 2000000
            clearScreen
            if (z == 1) then do
                rodada (z+1) n dica palavra coberta escolhidas tem rod jogas [((pegar_nome jogasT 1 1), 0), ((pegar_nome jogasT 1 2), (pegar_pontuacao jogasT 1 2)), ((pegar_nome jogasT 1 3), (pegar_pontuacao jogasT 1 3))] (sortear_numero_roleta 1 24)
            else if (z == 2) then do
                rodada (z+1) n dica palavra coberta escolhidas tem rod jogas [((pegar_nome jogasT 1 1), (pegar_pontuacao jogasT 1 1)), ((pegar_nome jogasT 1 2), 0), ((pegar_nome jogasT 1 3), (pegar_pontuacao jogasT 1 3))] (sortear_numero_roleta 1 24)
            else do
                rodada (z+1) n dica palavra coberta escolhidas tem rod jogas [((pegar_nome jogasT 1 1), (pegar_pontuacao jogasT 1 1)), ((pegar_nome jogasT 1 2), (pegar_pontuacao jogasT 1 2)), ((pegar_nome jogasT 1 3), 0)] (sortear_numero_roleta 1 24)
        else if (rol == "Passou a vez") then do
            putStrLn(">> Passou a vez!")
            threadDelay 2000000
            clearScreen
            rodada (z+1) n dica palavra coberta escolhidas tem rod jogas jogasT (sortear_numero_roleta 1 24)
        else do
            if ((pegar_nome jogas 1 z) == "Bot 01" || (pegar_nome jogas 1 z) == "Bot 02") then do
                clearScreen
                putStrLn(">> Valendo " ++ rol ++ " pontos por letra. " ++ (pegar_nome jogas 1 z) ++ " digite a palavra corretamente: ")
                let et = (read (pegar_item 1 2 bot) :: Bool)
                if(et) then do
                    if (z == 1) then do
                        rodada z n dica palavra palavra "" tem rod jogas [((pegar_nome jogasT 1 1), ((pegar_pontuacao jogasT 1 1) * ((read rol :: Int) * qnt_coberta coberta))), ((pegar_nome jogasT 1 2), 0), ((pegar_nome jogasT 1 3), 0)] (sortear_numero_roleta 1 24)
                    else if (z == 2) then do
                        rodada z n dica palavra palavra "" tem rod jogas [((pegar_nome jogasT 1 1), 0), ((pegar_nome jogasT 1 2), ((pegar_pontuacao jogasT 1 2) + ((read rol :: Int) * qnt_coberta coberta))), ((pegar_nome jogasT 1 3), 0)] (sortear_numero_roleta 1 24)
                    else do
                        rodada z n dica palavra palavra "" tem rod jogas [((pegar_nome jogasT 1 1), 0), ((pegar_nome jogasT 1 2), 0), ((pegar_nome jogasT 1 3), ((pegar_pontuacao jogasT 1 3) + ((read rol :: Int) * qnt_coberta coberta)))] (sortear_numero_roleta 1 24)
                else do 
                    putStrLn("Que pena, você errou a palavra...")
                    threadDelay 2000000
                    rodada (z+1) n dica palavra coberta escolhidas tem rod jogas jogasT (sortear_numero_roleta 1 24)
            else do
                clearScreen
                putStrLn(">> Valendo " ++ rol ++ " pontos por letra. " ++ (pegar_nome jogas 1 z) ++ " digite a palavra corretamente: ")
                le <- getLine
                if ((length le) == (length palavra)) then do
                    if ((palavra_correta le palavra)) then do
                        threadDelay 2000000
                        if (z == 1) then do
                            rodada z n dica palavra palavra "" tem rod jogas [((pegar_nome jogasT 1 1), ((pegar_pontuacao jogasT 1 1) * ((read rol :: Int) * qnt_coberta coberta))), ((pegar_nome jogasT 1 2), 0), ((pegar_nome jogasT 1 3), 0)] (sortear_numero_roleta 1 24)
                        else if (z == 2) then do
                            rodada z n dica palavra palavra "" tem rod jogas [((pegar_nome jogasT 1 1), 0), ((pegar_nome jogasT 1 2), ((pegar_pontuacao jogasT 1 2) * ((read rol :: Int) * qnt_coberta coberta))), ((pegar_nome jogasT 1 3), 0)] (sortear_numero_roleta 1 24)
                        else do
                            rodada z n dica palavra palavra "" tem rod jogas [((pegar_nome jogasT 1 1), 0), ((pegar_nome jogasT 1 2), 0), ((pegar_nome jogasT 1 3), ((pegar_pontuacao jogasT 1 3) + ((read rol :: Int) * qnt_coberta coberta)))] (sortear_numero_roleta 1 24)
                    else do
                        rodada (z+1) n dica palavra coberta escolhidas tem rod jogas jogasT (sortear_numero_roleta 1 24)
                        putStrLn("Que pena, você errou a palavra...")
                        threadDelay 2000000
                else do 
                    putStrLn("Que pena, você errou a palavra...")
                    threadDelay 2000000
                    rodada (z+1) n dica palavra coberta escolhidas tem rod jogas jogasT (sortear_numero_roleta 1 24)
    | otherwise = do
        let z = if (i > 3) then 1 else i
        putStrLn(">> Rodada N°: " ++ show(n))
        pontuacao_jogadores (pegar_nome jogasT 1 1) (pegar_pontuacao jogasT 1 1) (pegar_nome jogasT 1 2) (pegar_pontuacao jogasT 1 2) (pegar_nome jogasT 1 3) (pegar_pontuacao jogasT 1 3)
        tema tem
        putStrLn("Dica: " ++ dica)
        putStrLn("Palavra: " ++ coberta ++ " ||| " ++ palavra)
        putStrLn("Letra(s) já escolhida(s): " ++ escolhidas)
        putStrLn("Girando a roleta...")
        let rol = pegar_item 1 (sortea) roleta
        threadDelay 2000000
        if (rol == "Perdeu tudo") then do
            putStrLn(">> Perdeu tudo...")
            threadDelay 2000000
            clearScreen
            if (z == 1) then do
                rodada (z+1) n dica palavra coberta escolhidas tem rod jogas [((pegar_nome jogasT 1 1), 0), ((pegar_nome jogasT 1 2), (pegar_pontuacao jogasT 1 2)), ((pegar_nome jogasT 1 3), (pegar_pontuacao jogasT 1 3))] (sortear_numero_roleta 1 24)
            else if (z == 2) then do
                rodada (z+1) n dica palavra coberta escolhidas tem rod jogas [((pegar_nome jogasT 1 1), (pegar_pontuacao jogasT 1 1)), ((pegar_nome jogasT 1 2), 0), ((pegar_nome jogasT 1 3), (pegar_pontuacao jogasT 1 3))] (sortear_numero_roleta 1 24)
            else do
                rodada (z+1) n dica palavra coberta escolhidas tem rod jogas [((pegar_nome jogasT 1 1), (pegar_pontuacao jogasT 1 1)), ((pegar_nome jogasT 1 2), (pegar_pontuacao jogasT 1 2)), ((pegar_nome jogasT 1 3), 0)] (sortear_numero_roleta 1 24)
        else if (rol == "Passou a vez") then do
            putStrLn(">> Passou a vez!")
            threadDelay 2000000
            clearScreen
            rodada (z+1) n dica palavra coberta escolhidas tem rod jogas jogasT (sortear_numero_roleta 1 24)
        else do
            if ((pegar_nome jogas 1 z) == "Bot 01" || (pegar_nome jogas 1 z) == "Bot 02") then do
                putStrLn(">> Valendo " ++ rol ++ " pontos por letra, " ++ pegar_nome jogas 1 z ++ " digite uma letra: ")
                threadDelay 2000000
                let lel = (pegar_item 1 sortea letras)
                putStrLn(lel)
                threadDelay 2000000
                if (existe_letra escolhidas (toUpper (head lel))) then do
                    clearScreen
                    letraEscolhida
                    clearScreen
                    rodada (z+1) n dica palavra coberta escolhidas tem rod jogas jogasT (sortear_numero_roleta 1 24)
                else if(existe_letra palavra (toUpper (head lel))) then do
                    clearScreen
                    putStrLn("Parabéns, você acertou " ++ show(qnt_letra palavra (toUpper (head lel))) ++ " letras e ganhou " ++ show((qnt_letra palavra (toUpper (head lel))) * (read rol :: Int)) ++ " pontos")
                    threadDelay 2000000
                    if (z == 1) then do
                        rodada z n dica palavra (descobrir_letra palavra coberta (toUpper (head lel))) (escolhidas ++ [(toUpper (head lel))] ++ " ") tem rod jogas [((pegar_nome jogasT 1 1), ((pegar_pontuacao jogasT 1 1) * ((read rol :: Int) * (qnt_letra palavra (toUpper (head lel)))))), ((pegar_nome jogasT 1 2), (pegar_pontuacao jogasT 1 2)), ((pegar_nome jogasT 1 3), (pegar_pontuacao jogasT 1 3))] (sortear_numero_roleta 1 24)
                    else if (z == 2) then do
                        rodada z n dica palavra (descobrir_letra palavra coberta (toUpper (head lel))) (escolhidas ++ [(toUpper (head lel))] ++ " ") tem rod jogas [((pegar_nome jogasT 1 1), (pegar_pontuacao jogasT 1 1)), ((pegar_nome jogasT 1 2), ((pegar_pontuacao jogasT 1 2) * ((read rol :: Int) * (qnt_letra palavra (toUpper (head lel)))))), ((pegar_nome jogasT 1 3), (pegar_pontuacao jogasT 1 3))] (sortear_numero_roleta 1 24)
                    else do
                        rodada z n dica palavra (descobrir_letra palavra coberta (toUpper (head lel))) (escolhidas ++ [(toUpper (head lel))] ++ " ") tem rod jogas [((pegar_nome jogasT 1 1), (pegar_pontuacao jogasT 1 1)), ((pegar_nome jogasT 1 2), (pegar_pontuacao jogasT 1 2)), ((pegar_nome jogasT 1 3), ((pegar_pontuacao jogasT 1 3) * ((read rol :: Int) * (qnt_letra palavra (toUpper (head lel))))))] (sortear_numero_roleta 1 24)
                else do
                    clearScreen
                    putStrLn("Que pena, você não acertou nenhuma letra...")
                    threadDelay 2000000
                    rodada (z+1) n dica palavra coberta (escolhidas ++ [(toUpper (head lel))] ++ " ") tem rod jogas jogasT (sortear_numero_roleta 1 24)
            else do
                putStrLn(">> Valendo " ++ rol ++ " pontos por letra, " ++ pegar_nome jogas 1 z ++ " digite uma letra: ")
                le <- getLine
                if (existe_letra escolhidas (toUpper (head le))) then do
                    clearScreen
                    letraEscolhida
                    clearScreen
                    rodada (z+1) n dica palavra coberta escolhidas tem rod jogas jogasT (sortear_numero_roleta 1 24)
                else if(existe_letra palavra (toUpper (head le))) then do
                    clearScreen
                    putStrLn("Parabéns, você acertou " ++ show(qnt_letra palavra (toUpper (head le))) ++ " letras e ganhou " ++ show((qnt_letra palavra (toUpper (head le))) * (read rol :: Int)) ++ " pontos")
                    threadDelay 2000000
                    if (z == 1) then do
                        rodada z n dica palavra (descobrir_letra palavra coberta (toUpper (head le))) (escolhidas ++ [(toUpper (head le))] ++ " ") tem rod jogas [((pegar_nome jogasT 1 1), ((pegar_pontuacao jogasT 1 1) + ((read rol :: Int) * (qnt_letra palavra (toUpper (head le)))))), ((pegar_nome jogasT 1 2), (pegar_pontuacao jogasT 1 2)), ((pegar_nome jogasT 1 3), (pegar_pontuacao jogasT 1 3))] (sortear_numero_roleta 1 24)
                    else if (z == 2) then do
                        rodada z n dica palavra (descobrir_letra palavra coberta (toUpper (head le))) (escolhidas ++ [(toUpper (head le))] ++ " ") tem rod jogas [((pegar_nome jogasT 1 1), (pegar_pontuacao jogasT 1 1)), ((pegar_nome jogasT 1 2), ((pegar_pontuacao jogasT 1 2) + ((read rol :: Int) * (qnt_letra palavra (toUpper (head le)))))), ((pegar_nome jogasT 1 3), (pegar_pontuacao jogasT 1 3))] (sortear_numero_roleta 1 24)
                    else do
                        rodada z n dica palavra (descobrir_letra palavra coberta (toUpper (head le))) (escolhidas ++ [(toUpper (head le))] ++ " ") tem rod jogas [((pegar_nome jogasT 1 1), (pegar_pontuacao jogasT 1 1)), ((pegar_nome jogasT 1 2), (pegar_pontuacao jogasT 1 2)), ((pegar_nome jogasT 1 3), ((pegar_pontuacao jogasT 1 3) + ((read rol :: Int) * (qnt_letra palavra (toUpper (head le))))))] (sortear_numero_roleta 1 24)
                else do
                    clearScreen
                    putStrLn("Que pena, você não acertou nenhuma letra...")
                    threadDelay 2000000
                    rodada (z+1) n dica palavra coberta (escolhidas ++ [(toUpper (head le))] ++ " ") tem rod jogas jogasT (sortear_numero_roleta 1 24)

palavra_correta :: String -> String -> Bool
palavra_correta [] [] = True
palavra_correta (x:xs) (y:ys) | ((toUpper x) /= y) = False
                              | otherwise = palavra_correta xs ys

qnt_letra :: String -> Char -> Int
qnt_letra [] y = 0
qnt_letra (x:xs) y | (x == y) = 1 + qnt_letra xs y
                   | otherwise = qnt_letra xs y

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

cobrir_palavra :: String -> String
cobrir_palavra [] = []
cobrir_palavra (x:xs) | (x == ' ') = " " ++ cobrir_palavra (xs)
                      | otherwise = "#" ++ cobrir_palavra (xs)

main = do
    clearScreen
    telaInicial
    case1