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
        Tema \= "1", Tema \= "2", Tema \= "3", menus:opcaoInvalida, caso2;
        assert(tema(Tema)), caso3 
        ).
    
caso3() :-
    limpaTela,
    menus:escolherQtdRodadas,
    lerString(Qtd),
    atom_number(Qtd, X)->(
        X >= 1, X =< 10, assert(rodadas(Qtd)), caso4;
        menus:opcaoInvalida, caso3()
        ).
    
caso4():-
    limpaTela,
    menus: comecar,
    lerString(Y)->(
        Y == "1", umJogador([],[],[]);
        Y == "2", doisJogadores([],[],[]);
        Y == "3", tresJogadores([],[],[]);
        Y \= "1", Y \= "2", Y\= "3", menus:opcaoInvalida,caso4
        ).
    

    
umJogador(J, J2, J3):-
    writeln("Digite seu nome: "),
    lerString(Y),
    insereInicio(Y, J, R1),
    insereInicio(0, R1, R2),
    insereInicio("Bot 01", J2, T1),
    insereInicio(0, T1, T2),
    insereInicio("Bot 02", J3, P1),
    insereInicio(0, P1, P2),
    comecar(R2, T2, P2).
    
doisJogadores(J, J2, J3):-
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
    
tresJogadores(J, J2, J3):-
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