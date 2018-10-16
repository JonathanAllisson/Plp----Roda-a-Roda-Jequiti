import Control.Concurrent

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
    limpaTela

opcaoInvalida :: IO()
opcaoInvalida = do
    putStrLn "***********************************************************************"
    putStrLn "--------------------------- OPCÃO INVÁLIDA ----------------------------"
    putStrLn "***********************************************************************"
    threadDelay 2000000
    limpaTela

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
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "********************* RODA A RODA JEQUITI *****************************"
    putStrLn "----------------------  Comecar jogo 1  -------------------------------"
    putStrLn "-------------------------  Regras 2  ----------------------------------"
    putStrLn "------------------  Ranking vencedores 3  -----------------------------"
    putStrLn "***********************************************************************"
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "\t"
    putStrLn ">> Qual a sua escolha?"

escolherTema :: IO()
escolherTema = do
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "********************* RODA A RODA JEQUITI *****************************"
    putStrLn "-------------------------  Geografia 1  -------------------------------"
    putStrLn "--------------------------  Marcas 2  ---------------------------------"
    putStrLn "--------------------------  Filmes 3  ---------------------------------"
    putStrLn "***********************************************************************"
    putStrLn "-----------------------------------------------------------------------"
    putStrLn "\t"
    putStrLn ">> Qual a sua escolha? "
    threadDelay 2000000

case2 :: IO()
case2 = do
    escolherTema
    putStrLn "chegou ate aqui"

case1 :: IO()
case1 = do
    telaDeOpcoes
    op <- getLine 
    case op of "1" -> case2
               "2" -> regras
               _ -> opcaoInvalida 


iniciar = do
    limpaTela
    telaInicial
    case1
    

main = do
    iniciar