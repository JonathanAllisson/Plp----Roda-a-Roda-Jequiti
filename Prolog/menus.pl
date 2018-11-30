:- module(menus, []).

limpaTela() :-
	shell("clear").

opcaoInvalida :-
    writeln("***********************************************************************"),
    writeln("--------------------------- OPCÃO INVÁLIDA ----------------------------"),
    writeln("***********************************************************************"),
    sleep(1). 

regras :-
    writeln("Roda-a-Roda é um game-show apresentado por Sílvio Santos."),
    writeln("O objetivo é acertar a palavra da pista que for sorteada. Durante seu turno, você fará duas ações:"),
    writeln("1° Girar a roda de prêmios."),
    writeln("2° Escolher uma letra que possa existir nas palavras."),
    writeln("Caso a sua letra faça parte das palavras, você pontuará a quantia sorteada na roda."),
    writeln("*****ENTRETANTO a roda não possui apenas prêmios!***** "),
    writeln("Opções como 'Passou a Vez' e 'Perdeu Tudo' também podem ser encontradas na roda!"),
    writeln("Ao final do jogo (todas as palavras foram acertadas), o jogador com maior pontuação vence!."),
    writeln("O jogador vencedor irá participar de uma última rodada e poderá faturar 1 milhão de reais*."),
    writeln("*O pr?mio será pago em barras de ouro que valem mais do que dinheiro**."),
    writeln("** Atenção impostos e ou encargos poderão (irão com toda certeza) ser cobrados."),
    writeln("*****SE VOÇÊ ACHA QUE TEM DIREITO A COBRAR QUALQUER VALOR GANHO, TODA E QUALQUER RESPONSABILIDADE SOBRE ESSE JOGO É DO SISTEMA DE TELEVISÃO BRASILEIRO (SBT)*****"),  
    writeln(">> Digite a palavra sair para voltar."),
    read_line_to_string(user_input, X),
    string_upper(X, UpperCase)->(
        UpperCase \= "SAIR", limpaTela, opcaoInvalida, limpaTela, regras
    ).
    

telaInicial :-
    writeln("-----------------------------------------------------------------------"),
    writeln("***********************************************************************"),
    writeln("----------------------------  RODA  -----------------------------------"),
    writeln("---------------------------  A RODA  ----------------------------------"),
    writeln("--------------------------  JEQUITI  ----------------------------------"),
    writeln("***********************************************************************"),
    writeln("-----------------------------------------------------------------------"),
    writeln(">> Carregando..."),
    sleep(1).

telaDeOpcoes :-
    writeln("***********************************************************************"),
    writeln("--------------------- RODA A RODA JEQUITI -----------------------------"),
    writeln("***********************************************************************"),
    writeln("-------- Escolha o número referente a opção que deseja: ---------------"),
    writeln("-----------------------------------------------------------------------"),
    writeln("---------------------- 1. Começar o jogo ------------------------------"),
    writeln("---------------------- 2. Visualizar as regras ------------------------"),
    writeln("-----------------------------------------------------------------------"),
    writeln("***********************************************************************"),
    writeln("\t"),
    writeln(">> Qual a sua escolha?").

escolherTema :-
    writeln("***********************************************************************"),
    writeln("--------------------- RODA A RODA JEQUITI -----------------------------"),
    writeln("***********************************************************************"),
    writeln("-------- Escolha o número referente ao tema que deseja: ---------------"),
    writeln("-----------------------------------------------------------------------"),
    writeln("-------------------------- 1. Geografia -------------------------------"),
    writeln("-------------------------- 2. Marcas ----------------------------------"),
    writeln("-------------------------- 3. Filmes ----------------------------------"),
    writeln("-----------------------------------------------------------------------"),
    writeln("***********************************************************************"),
    writeln("\t"),
    writeln(">> Qual a sua escolha? ").


escolherQtdRodadas :-
    writeln("***********************************************************************"),
    writeln("--------------------- RODA A RODA JEQUITI -----------------------------"),
    writeln("***********************************************************************"),
    writeln("------------------------ /*/ De 1 a 10 /*/ ----------------------------"),
    writeln("------------------ Quantas rodadas você quer jogar? -------------------"),
    writeln("-----------------------------------------------------------------------"),
    writeln("***********************************************************************"),
    writeln("\t"),
    writeln(">> Qual a sua escolha? ").

comecar :-
    writeln("***********************************************************************"),
    writeln("---------------------- RODA A RODA JEQUITI ----------------------------"),
    writeln("***********************************************************************"),
    writeln("------------------------ /*/ De 1 a 3 /*/ -----------------------------"),
    writeln("----------------------- Quantos jogadores? ----------------------------"),
    writeln("-----------------------------------------------------------------------"),
    writeln("***********************************************************************"),
    writeln("\t"),
    writeln(">> Qual a sua escolha?").

pontuacaoGeral :-
    writeln("***********************************************************************"),
    writeln("------------------------ Pontuação Geral ------------------------------"),
    writeln("***********************************************************************").

parabens :-
    writeln("***********************************************************************"),
    writeln("------------- PARABENS, VOCE GANHOU 1 MILHAO DE REAIS!!! --------------"),
    writeln("***********************************************************************").