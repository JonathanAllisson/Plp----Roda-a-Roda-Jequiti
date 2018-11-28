:- initialization(main).
:- use_module(menus).
:- dynamic (tema/1).
:- dynamic(qtdRodadas/1).
:- dynamic(qtdJogadores/1).

/*loucura minha aki, Gasparsa
setup_palavra :-
    reconsult('arquivo.pl').
limitaPeloTema(Tema, Resultado):-
    setup_palavra,
    findall([Dica,Palavra, Tema], palavra(Dica,Palavra, Tema), Resultado).

escolhePalvra(Palavras, RandomPalavra):-
    length(Palavras, Size),
    random(0, Size, RandomIndex),
    nth0(RandomIndex, Palavras, RandomPalavra).

pegaTexto(Word, Texto):-
    nth0(0, Word, Texto).

palavraRandom:-  
    limitaPeloTema(Tema, Resultado),
    escolhePalvra(Resultado, RandomPalavra),
    pegaTexto(RandomPalavra, Texto).
*/

caso1 :-
    menus: limpaTela,
    menus:telaDeOpcoes,
    lerString(Op) -> ( 
        Op == "2", menus: limpaTela, menus: regras;
        Op == "1", caso2;
        Op \= "1", Op \= "2", menus: limpaTela, menus: opcaoInvalida, caso1;
        caso1
        ).
    
caso2 :-
    menus: limpaTela,
    menus:escolherTema,
    lerString(Tema)->(
        Tema \= "1", Tema \= "2", Tema \= "3", menus: limpaTela, menus: opcaoInvalida, caso2;
        true -> (Tema == "1", T = "Geografia"; Tema == "2", T = "Marcas"; Tema == "3", T = "Filmees"),
        assert(tema(T)), caso3
        ).
    
caso3() :-
    menus: limpaTela,
    menus:escolherQtdRodadas,
    lerString(Entrada),
    atom_number(Entrada, QtdRodadas)->(
        QtdRodadas >= 1, QtdRodadas =< 10, assert(qtdRodadas(QtdRodadas)), caso4;
        menus: limpaTela, menus:opcaoInvalida, caso3()
        ).
    
caso4():-
    menus: limpaTela,
    menus: comecar,
    lerString(Jogadores),
    cadastraJogadores(Jogadores).    

    
cadastraJogadores("1"):-
    menus: limpaTela,
    writeln("Digite seu nome: "),
    lerString(Nome),
    insereInicio(Nome, [], R1),
    insereInicio(0, R1, Jogador01),
    insereInicio("Bot 01", [], R2),
    insereInicio(0, R2, Jogador02),
    insereInicio("Bot 02", [], R3),
    insereInicio(0, R3, Jogador03),
    rodadas(Jogador01, Jogador02, Jogador03, 1).
    
cadastraJogadores("2"):-
    menus: limpaTela,
    writeln("Jogador 01, digite seu nome: "),
    lerString(Nome01),
    insereInicio(Nome01, [], R1),
    insereInicio(0, R1, Jogador01),
    menus: limpaTela,
    writeln("Jogador 02, digite seu nome: "),
    lerString(Nome02),
    insereInicio(Nome02, [], R2),
    insereInicio(0, R2, Jogador02),
    insereInicio("Bot 01", [], R3),
    insereInicio(0, R3, Jogador03),
    rodadas(Jogador01, Jogador02, Jogador03, 1).
    
cadastraJogadores("3"):-
    menus: limpaTela,
    writeln("Jogador 01, digite seu nome: "),
    lerString(Nome01),
    insereInicio(Nome01, [], R1),
    insereInicio(0, R1, Jogador01),
    menus: limpaTela,
    writeln("Jogador 02, digite seu nome: "),
    lerString(Nome02),
    insereInicio(Nome02, [], R2),
    insereInicio(0, R2,
    insereInicio(Nome02, [], R2),
    insereInicio(0, R2, Jogador02),
    menus: limpaTela,
    writeln("Jogador 03, digite seu nome: "),
    lerString(Nome03),
    insereInicio(Nome03, [], R3),
    insereInicio(0, R3, Jogador03),
    rodadas(Jogador01, Jogador02, Jogador03, 1).

cadastraJogadores(_) :-
    menus: limpaTela,
    menus:opcaoInvalida,
    caso4.
    
rodadas(Jogador01, Jogador02, Jogador03, NumeroRodada) :-
    qtdRodadas(X) ->
    (NumeroRodada > X, rodadaFinal;
    pegarPontuacaoNome(Jogador01, L1, NJ1),
    pegarPontuacaoNome(Jogador02, L2, NJ2),
    pegarPontuacaoNome(Jogador03, L3, NJ3),
    jogadas(1, [NJ1, 0], [NJ2, 0], [NJ3, 0], NumeroRodada, "jjj", "j j j", )
    write(">> Rodada N°: "), writeln(NumeroRodada),
    menus: pontuacaoGeral,
    pegarPontuacaoNome(Jogador01, P1, N1),
    pegarPontuacaoNome(Jogador02, P2, N2),
    pegarPontuacaoNome(Jogador03, P3, N3),
    write("Pontuação do jogador(a) "), write(N1), write(": "), writeln(P1),
    write("Pontuação do jogador(a) "), write(N2), write(": "), writeln(P2),
    write("Pontuação do jogador(a) "), write(N3), write(": "), writeln(P3), 
    sleep(1),
    Aux is (NumeroRodada + 1),
    rodadas(Jogador01, Jogador02, Jogador03, Aux)).

jogadas(Vez, PJ1, PJ2, PJ3, NumeroRodada, PalavraCoberta, Letras, RPJ1, RPJ2, RPJ3) :- 
    tema(T),
    write(">> Rodada N°: "), writeln(NumeroRodada),
    write("Tema: "), writeln(T),
    writeln("DICA - IMPLENTAR"),
    write("Palavra: "), writeln(PalavraCoberta),
    writeln("Letra(s) já escolhida(s): "),
    writeln("Girando a roleta..."),
    sleep(2),
    qtdCoberta(PalavraCoberta, C)
    -> (C < 3,
        C > 0,
        write("MENOR Q 3");
        C > 3,
        write("Valendo 100 pontos, digite uma letra: "),
        lerString(Tentativa)
    ).

nomeJogadorVez(Vez, Nome) :-.

rodadaFinal :-
    writeln("H89SH89ASHAS").

pegarPontuacaoNome([H|[Ht|_]], H, Ht).

insereInicio(H, L, [H|L]).

main :-
    menus: limpaTela,
    menus:telaInicial,
    caso1,
    halt(0).
    
lerString(X) :-
    read_line_to_string(user_input, X).