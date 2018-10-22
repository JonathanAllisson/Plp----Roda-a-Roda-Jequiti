import Control.Concurrent
import Control.Monad
import Data.Char

type Nome = String
type Pontuacao = Integer
type Jogador = (Nome, Pontuacao)

nome :: Jogador -> Nome
nome (n, p) = n

pontuacao :: Jogador -> Pontuacao
pontuacao (n, p) = p

roleta = (100, 150, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, "Passou a vez", "Perdeu tudo")
rodadas = 0
tema = " "
nJogadores = 0

limpaTela = do
    putStr "\ESC[2J"


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
    limpaTela
    case1

opcaoInvalida :: Int -> IO()
opcaoInvalida x = do
    limpaTela
    putStrLn "***********************************************************************"
    putStrLn "--------------------------- OPCÃO INVÁLIDA ----------------------------"
    putStrLn "***********************************************************************"
    threadDelay 2000000
    limpaTela
    case x of 1 -> case1
              2 -> case2
              3 -> case3
              4 -> case4

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
    threadDelay 2000000
    limpaTela
 
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

case4 :: IO()
case4 = do
    limpaTela
    comecar  
    nJogadores <- readLn :: IO Int
    case nJogadores of 1 -> umJogador
                       2 -> putStr "ainda por fazert"
                       3 -> putStr "ainda por fazer"
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
    let tema = input
    case3
    
case1 :: IO()
case1 = do
    telaDeOpcoes
    op <- getLine
    case op of "1" -> case2
               "2" -> regras
               _ -> opcaoInvalida 1

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

umJogador = do
    putStrLn ">> Digite seu nome: "
    n <- getLine
    let joga = (n, 0)
    putStrLn (nome joga) 
    putStrLn (show (pontuacao joga) )
    
iniciar = do
    limpaTela
    telaInicial
    case1
    

main = do
    iniciar