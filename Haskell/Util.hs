module Util (
    regras,
    telaInicial,
    telaDeOpcoes,
    escolherTema,
    escolherQtdRodadas,
    comecar,
    opcaoInvalidaPt,
    tema,
    pontuacao_jogadores
) where
        
import Control.Concurrent
import Control.Monad
import Data.Char

opcaoInvalidaPt :: IO()
opcaoInvalidaPt = do
    putStrLn "***********************************************************************"
    putStrLn "--------------------------- OPCÃO INVÁLIDA ----------------------------"
    putStrLn "***********************************************************************"
    threadDelay 2000000

regras :: IO()
regras = do
    putStrLn "Roda-a-Roda é um game-show apresentado por Sílvio Santos."
    putStrLn "O objetivo é acertar a palavra da pista que for sorteada. Durante seu turno, você fará duas ações:"
    putStrLn "1° Girar a roda de prêmios."
    putStrLn "2° Escolher uma letra que possa existir nas palavras."
    putStrLn "Caso a sua letra faça parte das palavras, você pontuará a quantia sorteada na roda."
    putStrLn "*****ENTRETANTO a roda não possui apenas prêmios!***** "
    putStrLn "Opções como 'Passou a Vez' e 'Perdeu Tudo' também podem ser encontradas na roda!"
    putStrLn "Ao final do jogo (todas as palavras foram acertadas), o jogador com maior pontuação vence!."
    putStrLn "O jogador vencedor irá participar de uma última rodada e poderá faturar 1 milhão de reais*."
    putStrLn "*O prẽmio será pago em barras de ouro que valem mais do que dinheiro**."
    putStrLn "** Atenção impostos e ou encargos poderão (irão com toda certeza) ser cobrados."
    putStrLn "*****SE VOÇÊ ACHA QUE TEM DIREITO A COBRAR QUALQUER VALOR GANHO, TODA E QUALQUER RESPONSABILIDADE SOBRE ESSE JOGO É DO SISTEMA DE TELEVISÃO BRASILEIRO (SBT)*****"  
    putStrLn ">> Digite a palavra sair para voltar."
    threadDelay 2000000
    inp <- getLine
    when (map toUpper inp /= "SAIR") $ do
        regras

telaInicial :: IO()
telaInicial = do
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "***********************************************************************"
    putStrLn "----------------------------  RODA  -----------------------------------"
    putStrLn "---------------------------  A RODA  ----------------------------------"
    putStrLn "--------------------------  JEQUITI  ----------------------------------"
    putStrLn "***********************************************************************"
    putStrLn "-----------------------------------------------------------------------"
    putStrLn ">> Carregando..."

telaDeOpcoes :: IO()
telaDeOpcoes = do
    putStrLn "***********************************************************************"
    putStrLn "--------------------- RODA A RODA JEQUITI -----------------------------"
    putStrLn "***********************************************************************"
    putStrLn "-------- Escolha o número referente a opção que deseja: ---------------"
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "---------------------- 1. Começar o jogo ------------------------------"
    putStrLn "---------------------- 2. Visualizar as regras ------------------------"
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "***********************************************************************"
    putStrLn "\t"
    putStrLn ">> Qual a sua escolha?"

escolherTema :: IO()
escolherTema = do
    putStrLn "***********************************************************************"
    putStrLn "--------------------- RODA A RODA JEQUITI -----------------------------"
    putStrLn "***********************************************************************"
    putStrLn "-------- Escolha o número referente ao tema que deseja: ---------------"
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "-------------------------- 1. Geografia -------------------------------"
    putStrLn "-------------------------- 2. Marcas ----------------------------------"
    putStrLn "-------------------------- 3. Filmes ----------------------------------"
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "***********************************************************************"
    putStrLn "\t"
    putStrLn ">> Qual a sua escolha? "
    
escolherQtdRodadas :: IO()
escolherQtdRodadas = do
    putStrLn "***********************************************************************"
    putStrLn "--------------------- RODA A RODA JEQUITI -----------------------------"
    putStrLn "***********************************************************************"
    putStrLn "------------------------ /*/ De 1 a 9 /*/ -----------------------------"
    putStrLn "------------------ Quantas rodadas você quer jogar? -------------------"
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "***********************************************************************"
    putStrLn "\t"
    putStrLn ">> Qual a sua escolha? "

comecar :: IO()
comecar = do
    putStrLn "***********************************************************************"
    putStrLn "--------------------- RODA A RODA JEQUITI -----------------------------"
    putStrLn "***********************************************************************"
    putStrLn "----------------------- ESCOLHA UMA OPCAO:: ---------------------------"
    putStrLn "--------------------- UM JOGADOR DIGITE 1 -----------------------------"
    putStrLn "----------------------DOIS JOGADORES DIGITE 2 -------------------------"
    putStrLn "----------------------TRES JOGADORES DIGITE 3--------------------------"
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "***********************************************************************"
    putStrLn "\t"
    putStrLn ">> Qual a sua escolha?"

tema :: Int -> IO()
tema n = do
    case n of 1 -> putStrLn("Tema: Geografia")
              2 -> putStrLn("Tema: Marcas")
              3 -> putStrLn("Tema: Filmes")

pontuacao_jogadores :: String -> Int -> String -> Int -> String -> Int -> IO()
pontuacao_jogadores j1 p1 j2 p2 j3 p3 = do
    putStrLn("**************************** Pontuação: *******************************")
    putStrLn(j1 ++ ": " ++ show(p1) ++ " pontos" ++ "     ||     " ++ j2 ++ ": " ++ show(p2) ++ " pontos" ++ "     ||     " ++ j3 ++ ": " ++ show(p3) ++ " pontos\n")