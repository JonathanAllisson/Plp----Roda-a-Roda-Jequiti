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
    insereInicio("Bot 01", J2, R3),
    insereInicio("Bot 02", J3, R4),
    comecar(R2, R3, R4).
    
doisJogadores(J, J2, J3):-
    writeln("Digite seu nome: "),
    lerString(Y),
    J.append(Y),
    J.append(0),
    writeln("Digite seu nome: "),
    lerString(Z),
    J2.append(Z),
    J2.append(0),
    J3.append("Bot 02"),
    J3.append(0),
    comecar(J, J2, J3).
    
tresJogadores(J, J2, J3):-
    writeln("Digite seu nome: "),
    lerString(Y),
    J.append(Y),
    J.append(0),
    writeln("Digite seu nome: "),
    lerString(Z),
    J2.append(Z),
    J2.append(0),
    writeln("Digite seu nome: "),
    lerString(X),
    J3.append(X),
    J3.append(0),
    comecar(J, J2, J3).
    
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