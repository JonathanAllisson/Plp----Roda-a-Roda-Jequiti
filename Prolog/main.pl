:- initialization(main).
:- use_module(menus).
:- dynamic (tema/1).
:- dynamic(qtdRodadas/1).
:- dynamic(qtdJogadores/1).

arquivo(Lines) :-
    open('Palavras.txt', read, Str),
    read_file(Str,Lines),
    close(Str).

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream,L).

lista(X) :- X = [50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,"Perdeu tudo","Perdeu tudo","Passou a vez","Passou a vez","Passou a vez"].

roleta(Y):-
    lista(X),
    random_member(Y, X).

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
    insereInicio(0,[], R2),
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
        pegarPontuacaoNome(Jogador01, _, NJ1),
        pegarPontuacaoNome(Jogador02, _, NJ2),
        pegarPontuacaoNome(Jogador03, _, NJ3),
        jogadas(1, [NJ1, 0], [NJ2, 0], [NJ3, 0], NumeroRodada, "jjj", "j j j", 0, 0, 0),
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

jogadas(Vez, [H1|[HT1|_]], [H2|[HT2|_]], [H3|[HT3|_]], NumeroRodada, PalavraCoberta, Letras, PJ1, PJ2, PJ3) :- 
    tema(T),
    menus: limpaTela,
    write(">> Rodada N°: "), writeln(NumeroRodada),
    writeln("*************************** Pontuação *********************************"),
    write(H1), write(": "), write(HT1), write(" pontos    ||    "),
    write(H2), write(": "), write(HT2), write(" pontos    ||    "),
    write(H3), write(": "), write(HT3), writeln(" pontos"),
    writeln("***********************************************************************"),
    write("Tema: "), writeln(T),
    alteraVez(Vez, Nvez),
    writeln("DICA - IMPLENTAR"),
    write("Palavra: "), writeln(PalavraCoberta),
    writeln("Letra(s) já escolhida(s): "),
    writeln("Girando a roleta..."),
    C is 4,
    sleep(2),
    roleta(R),
    nomeDaVez(Vez, H1, H2, H3, N) -> (
        C < 3,
        C > 0,
        write("Valendo "), write(R), write(" pontos por letra restante, "), write(N), writeln(" digite a palavra corretamente:")
        ;
        C > 3 -> (
            R == "Perdeu tudo",
            writeln("Perdeu tudo..."),
            zeraPontuacao(Vez, HT1, HT2, HT3, NP1, NP2, NP3), 
            sleep(2), 
            jogadas(Nvez, [H1|[NP1]], [H2|[NP2]], [H3|[NP3]], NumeroRodada, PalavraCoberta, Letras, PJ1, PJ2, PJ3);
            R == "Passou a vez",
            writeln("Passou a vez..."),
            sleep(2),
            jogadas(Nvez, [H1|[HT1]], [H2|[HT2]], [H3|[HT3]], NumeroRodada, PalavraCoberta, Letras, PJ1, PJ2, PJ3);
            write(">> Valendo "), write(R), write(" pontos por letra, "), write(N), writeln(" digite uma letra:"),
            sleep(2),
            alterarPontuacao(Vez, HT1, HT2, HT3, R, NP1, NP2, NP3),
            jogadas(Nvez, [H1|[NP1]], [H2|[NP2]], [H3|[NP3]], NumeroRodada, PalavraCoberta, Letras, PJ1, PJ2, PJ3))).

alteraVez(Vez, R) :-
    Vez =:= 1, R is 2;
    Vez =:= 2, R is 3;
    R is 1.

nomeDaVez(Vez, H1, H2, H3, R) :- 
    Vez =:= 1, R = H1;
    Vez =:= 2, R = H2;
    R = H3.

zeraPontuacao(Vez, P1, P2, P3, NP1, NP2, NP3) :-
    Vez =:= 1, NP1 is 0, NP2 = P2, NP3 = P3;
    Vez =:= 2, NP1 = P1, NP2 is 0, NP3 = P3;
    NP1 = P1, NP2 = P2, NP3 is 0.

alterarPontuacao(Vez, P1, P2, P3, N, NP1, NP2, NP3) :-
    Vez =:= 1, K1 is (P1 + N), NP1 = K1, NP2 = P2, NP3 = P3;
    Vez =:= 2, K2 is (P2 + N), NP1 = P1, NP2 = K2, NP3 = P3;
    K3 is (P3 + N), NP1 = P1, NP2 = P2, NP3 = K3.

rodadaFinal :-
    writeln("H89SH89ASHAS").

pegarPontuacaoNome([H|[Ht|_]], H, Ht).

insereInicio(H, L, [H|L]).

cobre(' ', " ").
cobre(_, "#").
cobrirPalavra([], []).
cobrirPalavra([H|T], [R|T2]):-
    cobre(H, R), cobrirPalavra(T, T2).

qnt_coberta([], 0).
qnt_coberta([H|T], K):-
    qnt_coberta(T, Q) -> (
        H == '#', K is Q + 1;
        K is Q).

main :-
    menus: limpaTela,
    menus:telaInicial,
    caso1,
    halt(0).
    
lerString(X) :-
    read_line_to_string(user_input, X).