:- module(main, [limpaTela/0]).
:- initialization(main).
:- use_module(menus).
:- dynamic palavra/3,(tema/1).
:- dynamic(rodadas/1).
:- dynamic(qtdJogadores/1).
% loucura minha aki, Gasparsa
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
%%%-----------------------------------------------
limpaTela() :-
	shell("clear").

caso1 :-
    limpaTela,
    menus:telaDeOpcoes,
    lerString(Op) -> ( 
        Op == "2", limpaTela, menus:regras;
        Op == "1", caso2;
        Op \= "1", Op \= "2", limpaTela, menus: opcaoInvalida, caso1;
        caso1
        ).
    
caso2 :-
    limpaTela,
    menus:escolherTema,
    lerString(Tema)->(
        Tema \= "1", Tema \= "2", Tema \= "3", limpaTela, menus:opcaoInvalida, caso2;
        assert(tema(Tema)), caso3 
        ).
    
caso3() :-
    limpaTela,
    menus:escolherQtdRodadas,
    lerString(Entrada),
    atom_number(Entrada, QtdRodadas)->(
        QtdRodadas >= 1, QtdRodadas =< 10, assert(rodadas(Entrada)), caso4;
        limpaTela, menus:opcaoInvalida, caso3()
        ).
    
caso4():-
    limpaTela,
    menus: comecar,
    lerString(Y),
    cadastraJogadores(Y, [], [], []).    

    
cadastraJogadores("1", J, J2, J3):-
    writeln("Digite seu nome: "),
    lerString(Y),
    insereInicio(Y, J, R1),
    insereInicio(0, R1, R2),
    insereInicio("Bot 01", J2, T1),
    insereInicio(0, T1, T2),
    insereInicio("Bot 02", J3, P1),
    insereInicio(0, P1, P2),
    comecar(R2, T2, P2).
    
cadastraJogadores("2", J, J2, J3):-
    writeln("Digite seu nome: "),
    lerString(Y),
    insereInicio(Y, J, R1),
    insereInicio(0, R1, R2),
    writeln("Digite seu nome: "),
    lerString(Z),
    insereInicio(Z, J2, K1),
    insereInicio(0, K1, K2),
    insereInicio("Bot 01", J3, T1),
    insereInicio(0, T1, T2),
    comecar(R2, K2, T2).
    
cadastraJogadores("3", J, J2, J3):-
    writeln("Digite seu nome: "),
    lerString(Y),
    insereInicio(Y, J, R1),
    insereInicio(0, R1, R2),
    writeln("Digite seu nome: "),
    lerString(Z),
    insereInicio(Z, J2, K1),
    insereInicio(0, K1, K2),
    writeln("Digite seu nome: "),
    lerString(N),
    insereInicio(N, J3, F1),
    insereInicio(0, F1, F2),
    comecar(R2, K2, F2).

cadastraJogadores(_, _, _, _) :-
    limpaTela,
    menus:opcaoInvalida,
    caso4.
    
comecar([H|T], [H2|T2], [H3|T3]):-
    writeln(H),
    writeln(T),
    writeln(H2),
    writeln(T2),
    writeln(H3),
    writeln(T3).
insereInicio(H, L, [H|L]):- !.


main :-
    limpaTela,
    menus:telaInicial,
    caso1,
    halt(0).
    
    
lerString(X) :-
    read_line_to_string(user_input, X).