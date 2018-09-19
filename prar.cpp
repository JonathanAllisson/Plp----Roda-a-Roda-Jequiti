#include <iostream>
#include <stdlib.h>
#include <time.h>

using namespace std;

int girar_roleta(int ){
    cout << "ok" << endl;
}

int main()
{
    int entrada;
    int pontuacao1 = 0;
    int pontuacao2 = 0;
    string jogador1, jogador2;
    
    //int jogadores[3];
    //cout << sizeof(jogadores)/sizeof(int) << endl;
    cout << "***** RODA A RODA JEQUITI *****" << endl;
    cout << "ESCOLHA UMA OPCAO:" << endl;
    cout << "UM JOGADOR DIGITE 1" <<endl;
    cout << "DOIS JOGADORES DIGITE 2" << endl;
    //cout << "TRES JOGADORES DIGITE 3" << endl;
    cin >> entrada;

    switch(entrada){
        case 1:
            cin >> jogador1;
            jogador2 = "IA";
            break;
        case 2:
            cin >> jogador1;
            cin >> jogador2;
            break;
        case 0:
            break;
        
        default:
            main();
        
    }
    int vez = 0;
    while(pontuacao1 != 10000 || pontuacao2 != 10000){
        if(vez == 0){
            string acao = "347d72b"; 
            while(acao == "347d72b"){
                cout << "Jogador 1, pressione alguma letra para girar a roleta" << endl;
                cin >> acao;
            }
            vez = 1;
            girar_roleta(pontuacao1);

        }
        else{
            cout << "ferrou" << endl;
            vez = 0;
        }


    }



    return 0;
}