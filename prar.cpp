
#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <cstring>
#include <fstream>

using namespace std;

struct Jogador{
    string nome;
    int pontuacao;

};

int girar_roleta(){

    return rand()% (11-0) + 0;
}

void rodada_do_but(Jogador j, string roleta[], int & p_rodada){
    //digite aqui a acao do fdp
}

void rodada(Jogador & j, string roleta[], int & p_rodada){
    if(j.nome == "IA")
    rodada_do_but(j, roleta, p_rodada);
    char letra;
    int r_roleta;
    cout << j.nome << ", pressione alguma ENTER para girar a roleta" << endl;
    getchar();  
    r_roleta = girar_roleta();
    if(r_roleta == 10){
        cout << "Passou a vez" << endl;
    }
    else if(r_roleta == 11){
        p_rodada = 0;
        cout << "Perdeu tudo" << endl;
    }else{
        cout << "Valendo " << roleta[r_roleta] << " pontos, digite uma letra:" << endl;
        cin >> letra;
        getchar();
    }
    
}
int main()
{
    srand((unsigned)time(0));
    // como ler arquivos de texto
    ifstream palavras;
    string linha;
    palavras.open("palavrasedicas.txt");
    getline(palavras, linha);
    // nao consegui quebrar a string em duas 
    

    int entrada;
    int pontuacao1 = 0;
    int pontuacao2 = 0;
    string roleta[12] = {"100", "200", "300", "400", "500", "600", "700", "800", "900", "1000", "Passou a vez", "Perdeu tudo"}; 
    
    Jogador jogadores[3];
    //cout << sizeof(jogadores)/sizeof(int) << endl;
    cout << "***** RODA A RODA JEQUITI *****" << endl;
    cout << "ESCOLHA UMA OPCAO:" << endl;
    cout << "UM JOGADOR DIGITE 1" <<endl;
    cout << "DOIS JOGADORES DIGITE 2" << endl;
    //cout << "TRES JOGADORES DIGITE 3" << endl;
    cin >> entrada;
    switch(entrada){
        case 1:
            cout << "Digite seu nome: " << endl;
            cin >> jogadores[0].nome ;
            getchar();
            jogadores[0].pontuacao = 0;
            jogadores[1].nome = "IA";
            jogadores[1].pontuacao = 0;
            break;
        case 2:
            cout << "Jogador 1, digite seu nome: " << endl;
            cin >> jogadores[0].nome ;
            jogadores[0].pontuacao = 0;
            cout << "Jogador 2, digite seu nome: " << endl;
            cin >> jogadores[1].nome ;
            getchar();
            jogadores[1].pontuacao = 0;
            break;
        case 0:
            break;
        
        default:
            main();
        
    }
    int vez = 0;
    int pontuacao_rodada_j1 = 0;
    int pontuacao_rodada_j2 = 0;
    while(jogadores[0].pontuacao != 10000 || jogadores[1].pontuacao != 10000){
        if(vez == 0){
            rodada(jogadores[0], roleta, pontuacao_rodada_j1);
            vez = 1;
        }
        else{
            rodada(jogadores[1], roleta, pontuacao_rodada_j2);
            vez = 0;
            
        }


    }



    return 0;
}