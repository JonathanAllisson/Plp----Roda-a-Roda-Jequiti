:- initialization(main).

:- use_module(menus).

:- dynamic(tema/1).
:- dynamic(rodadas/1).

limpaTela() :-
	shell("clear"),
	true.

caso1 :-
    limpaTela,
    menus:telaDeOpcoes,
    lerString(Op)->( 
        Op == "2", limpaTela, menus:regras;
        Op == "1", caso2;
        menus:opcaoInvalidaPt, caso1
        ).
    
caso2 :-
    limpaTela,
    menus:escolherTema,
    lerString(Tema)->(
        Tema \= "1", Tema \= "2", Tema \= "3", menus:opcaoInvalidaPt, caso2;
        assert(tema(Tema)), caso3 
        ).
    
caso3() :-
    limpaTela,
    menus:escolherQtdRodadas,
    lerString(Qtd),
    atom_number(Qtd, X)->(
        X >= 1, X =< 10, assert(rodadas(Qtd)), caso4;
        menus:opcaoInvalidaPt, caso3()
        ).
    
caso4():-
    writeln("OKKK"),
    rodadas(F),
    tema(G),
    writeln(F),
    writeln(G).
    

main :-
    limpaTela,
    menus:telaInicial,
    caso1,
    halt(0).
    
    
lerString(X) :-
    read_line_to_string(user_input, X).