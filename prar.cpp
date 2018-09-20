#include <iostream>
#include <stdlib.h>
#include <time.h>

using namespace std;

struct Jogador{
    string nome;
    int pontuacao;

};

int girar_roleta(){

    return rand()%12;
}

// void rodada(Jogador &j, int &pontuacao){
//     int resultado_roleta;
//     char letra;
//     cout << j.nome << ", pressione alguma ENTER para girar a roleta" << endl;
//     getchar();  
//     resultado_roleta = girar_roleta();
//         if(resultado_roleta == 10){
//             cout << "Passou a vez" << endl;
//         }
//         else if(resultado_roleta == 11){
//             pontuacao_rodada_j1 = 0;
//             cout << "Perdeu tudo" << endl;
//         }else{
//             cout << "Valendo " << roleta[resultado_roleta] << " pontos, digite uma letra:" << endl;
//             cin >> letra;
//             getchar();
//         }
// }

int main()
{
    int entrada;
    int pontuacao1 = 0;
    int pontuacao2 = 0;
    string roleta[12] = {"100", "200", "300", "400", "500", "600", "700", "800", "900", "1000", "Passou a vez", "Perdeu tudo"}; 
    
    //int jogadores[3];
    //cout << sizeof(jogadores)/sizeof(int) << endl;
    cout << "***** RODA A RODA JEQUITI *****" << endl;
    cout << "ESCOLHA UMA OPCAO:" << endl;
    cout << "UM JOGADOR DIGITE 1" <<endl;
    cout << "DOIS JOGADORES DIGITE 2" << endl;
    //cout << "TRES JOGADORES DIGITE 3" << endl;
    cin >> entrada;

    Jogador jogador1;
    Jogador jogador2;
    switch(entrada){
        case 1:
            cout << "Digite seu nome: " << endl;
            cin >> jogador1.nome ;
            getchar();
            jogador1.pontuacao = 0;
            jogador2.nome = "IA";
            jogador2.pontuacao = 0;
            break;
        case 2:
            cout << "Digite seu nome: " << endl;
            cin >> jogador1.nome ;
            jogador1.pontuacao = 0;
            cout << "Digite seu nome: " << endl;
            cin >> jogador2.nome ;
            getchar();
            jogador2.pontuacao = 0;
            break;
        case 0:
            break;
        
        default:
            main();
        
    }
    int vez = 0;
    int pontuacao_rodada_j1 = 0;
    int pontuacao_rodada_j2 = 0;
    char letra;
    int resultado_roleta;
    while(jogador1.pontuacao != 10000 || jogador2.pontuacao != 10000){
        if(vez == 0){
            cout << jogador1.nome << ", pressione alguma ENTER para girar a roleta" << endl;
            getchar();  
            resultado_roleta = girar_roleta();
            vez = 1;
            if(resultado_roleta == 10){
                 cout << "Passou a vez" << endl;
             }
            else if(resultado_roleta == 11){
                pontuacao_rodada_j1 = 0;
                cout << "Perdeu tudo" << endl;
            }else{
                cout << "Valendo " << roleta[resultado_roleta] << " pontos, digite uma letra:" << endl;
                cin >> letra;
                getchar();
            }
        }
        else{
            cout << jogador2.nome << ", pressione alguma ENTER para girar a roleta" << endl;
            getchar();  
            resultado_roleta = girar_roleta();
            vez = 0;
            if(resultado_roleta == 10){
                 cout << "Passou a vez" << endl;
             }
            else if(resultado_roleta == 11){
                pontuacao_rodada_j1 = 0;
                cout << "Perdeu tudo" << endl;
            }else{
                cout << "Valendo " << roleta[resultado_roleta] << " pontos, digite uma letra:" << endl;
                cin >> letra;
                getchar();
            }
            
        }


    }



    return 0;
}