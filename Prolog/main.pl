:- module(main, [limpaTela/0]).
:- initialization(main).
:- use_module(menus).
:- dynamic(tema/1).
:- dynamic(rodadas/1).
:- dynamic(qtdJogadores/1).

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
    lerString(Jogadores)->(
        Jogadores == "1", umJogador;
        Jogadores == "2", doisJogadores([],[],[]);
        Jogadores == "3", tresJogadores([],[],[]);
        Jogadores \= "1", Jogadores \= "2", Jogadores \= "3", limpaTela, menus:opcaoInvalida,caso4
        ).
    

    
umJogador :-
    limpaTela,
    writeln("Digite seu nome: "),
    lerString(Nome),
    insereInicio(Nome, [], Aux01),
    insereInicio(0, Aux01, Jogador01),
    insereInicio("Bot 01", [], Aux02),
    insereInicio(0, Aux02, Jogador02),
    insereInicio("Bot 02", [], Aux03),
    insereInicio(0, Aux03, Jogador03),
    comecar(Jogador01, Jogador02, Jogador03).
    
doisJogadores(J, J2, J3):-
    limpaTela,
    writeln("Jogador 01, digite seu nome: "),
    lerString(Y),
    insereInicio(Y, J, R1),
    insereInicio(0, R1, R2),
    limpaTela,
    writeln("Jogador 02, digite seu nome: "),
    lerString(Z),
    insereInicio(Z, J2, K1),
    insereInicio(0, K1, K2),
    insereInicio("Bot 01", J3, T1),
    insereInicio(0, T1, T2),
    comecar(R2, K2, T2).
    
tresJogadores(J, J2, J3):-
    limpaTela,
    writeln("Jogador 01, digite seu nome: "),
    lerString(Y),
    insereInicio(Y, J, R1),
    insereInicio(0, R1, R2),
    limpaTela,
    writeln("Jogador 02, digite seu nome: "),
    lerString(Z),
    insereInicio(Z, J2, K1),
    insereInicio(0, K1, K2),
    limpaTela,
    writeln("Jogador 03, digite seu nome: "),
    lerString(N),
    insereInicio(N, J3, F1),
    insereInicio(0, F1, F2),
    comecar(R2, K2, F2).
    
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