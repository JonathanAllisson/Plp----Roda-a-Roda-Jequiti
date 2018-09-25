#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <cstring>
#include <fstream>
#include <algorithm>
#include <cstdlib>
#include <ctime>
#include <string>
#include <unistd.h>
#include <stdio.h>

using namespace std;

string comeco;
string sair;
int opcao;
int entrada;
int pontuacao1 = 0;
int pontuacao2 = 0;
int pontuacao3 = 0;
string roleta[12] = {"100", "200", "300", "400", "500", "600", "700", "800", "900", "1000", "Passou a vez", "Perdeu tudo"};

void telaInicial();
void iniciar();
void limparTela();
void telaOpcoes();
void comecar();
void umJogador();
void doisJogadores();
void tresJogadores();
void regras();
void jogo();
void sleepcp(int milliseconds);
void opcaoInvalida(bool escolha);
void case1();
void case2();

struct Jogador{
    string nome;
    int pontuacao;
};

Jogador jogadores[3];
void rodada(Jogador &j, int &p_rodada);
void jodada_do_bot(Jogador j, int & p_rodada);
void jogada(Jogador j, int & p_rodada);

void sleepcp(int milliseconds) {// Cross-platform sleep function
    #ifdef WIN32
        Sleep(milliseconds);
    #else
    -    usleep(milliseconds * 1000);
    #endif // win32
}

void limparTela() {
	#ifdef WINDOWS
		std::system("cls");
	#else
		std::system("clear");
	#endif
}

void opcaoInvalida(bool escolha) {
    cout << "***********************************************************************" << endl;
    cout << "--------------------------- OPCÃO INVÁLIDA ----------------------------" << endl;
    cout << "***********************************************************************" << endl;
    sleepcp(2000);
    limparTela();
    if(escolha) {
        case1();
    } else {
        case2();
    }
}

void case2() {
    comecar();
    limparTela();
    switch(entrada){
        case 1:
            umJogador();
            break;
        case 2:
            doisJogadores();
            break;
        case 3:
            tresJogadores();
            break;
        default:
            opcaoInvalida(false);
    }
}

void case1() {
    telaOpcoes();
    limparTela();
    switch(opcao){
        case 1:
            case2();
            break;
        case 2:
            cout << opcao << endl;
			regras();
            break;
        case 3:
            cout << "Ranking em construção" << endl;
            break;
        default:
            opcaoInvalida(true);
    }
}

void iniciar() {
	limparTela();
    telaInicial();
    case1();
}

void telaInicial() {
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "***********************************************************************" << endl;
    cout << "----------------------------  RODA  -----------------------------------" << endl;
    cout << "---------------------------  A RODA  ----------------------------------" << endl;
    cout << "--------------------------  JEQUITI  ----------------------------------" << endl;
    cout << "***********************************************************************" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
	cout << ">> Carregando..." << endl;
	sleepcp(3000);	
	limparTela();
}

void telaOpcoes(){
	cout << "-----------------------------------------------------------------------" << endl;
    cout << "********************* RODA A RODA JEQUITI *****************************" << endl;
    cout << "----------------------  Comecar jogo 1  -------------------------------" << endl;
    cout << "-------------------------  Regras 2  ----------------------------------" << endl;
    cout << "------------------  Ranking vencedores 3  -----------------------------" << endl;
    cout << "***********************************************************************" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "																		" << endl;
    cout << ">> Qual a sua escolha? " << endl;
	cin >> opcao;
	limparTela();
}

void comecar(){
	cout << "-----------------------------------------------------------------------" << endl;
	cout << "********************* RODA A RODA JEQUITI *****************************" << endl;
    cout << "----------------------ESCOLHA UMA OPCAO:-------------------------------" << endl;
    cout << "----------------------UM JOGADOR DIGITE 1------------------------------" <<endl;
    cout << "----------------------DOIS JOGADORES DIGITE 2--------------------------" << endl;
    cout << "----------------------TRES JOGADORES DIGITE 3--------------------------" << endl;
    cout << "***********************************************************************" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "																		" << endl;
    cout << ">> Qual a sua escolha?" << endl;
    cin >> entrada;
}

void umJogador(){
	cout << ">> Digite seu nome: " << endl;
	cin >> jogadores[0].nome ;
	jogadores[0].pontuacao = 0;
	jogadores[1].nome = "Bot 01";
	jogadores[1].pontuacao = 0;
	jogadores[2].nome = "Bot 02";
	jogadores[2].pontuacao = 0;
	limparTela();
}

void doisJogadores(){	
	cout << "Jogador 01, digite seu nome: " << endl;
	cin >> jogadores[0].nome ;
	jogadores[0].pontuacao = 0;
	cout << "Jogador 02, digite seu nome: " << endl;
	cin >> jogadores[1].nome ;
	jogadores[1].pontuacao = 0;
	jogadores[2].nome = "Bot 01";
	jogadores[2].pontuacao = 0;
	limparTela();
}

void tresJogadores(){
	cout << "Jogador 01, digite seu nome: " << endl;
	cin >> jogadores[0].nome ;
	jogadores[0].pontuacao = 0;
	cout << "Jogador 02, digite seu nome: " << endl;
	cin >> jogadores[1].nome ;
	jogadores[1].pontuacao = 0;
	cout << "Jogador 03, digite seu nome: " << endl;
	cin >> jogadores[2].nome ;
	jogadores[2].pontuacao = 0;
	limparTela();
}

void regras(){
	cout << "Roda-a-Roda é um game-show apresentado por Sílvio Santos." << endl;
	cout << "O objetivo é acertar a palavra da pista que for sorteada. Durante seu turno, você fará duas ações:" << endl;
	cout << "1° Girar a roda de prêmios." << endl;
	cout << "2° Escolher uma letra que possa existir nas palavras." << endl;
	cout << "Caso a sua letra faça parte das palavras, você pontuará a quantia sorteada na roda." << endl; 
	cout << "*****ENTRETANTO a roda não possui apenas prêmios!***** " << endl;
	cout << "Opções como 'Passou a Vez' e 'Perdeu Tudo' também podem ser encontradas na roda!" << endl;
	cout << "Ao final do jogo (todas as palavras foram acertadas), o jogador com maior pontuação vence!." << endl;
	cout << "O jogador vencedor irá participar de uma última rodada e poderá faturar 1 milhão de reais*." << endl;
	cout << "*O prẽmio será pago em barras de ouro que valem mais do que dinheiro**." << endl;	        
	cout << "** Atenção impostos e ou encargos poderão (irão com toda certeza) ser cobrados." << endl;
	cout << "*****SE VOÇÊ ACHA QUE TEM DIREITO A COBRAR QUALQUER VALOR GANHO, TODA E QUALQUER RESPONSABILIDADE SOBRE ESSE JOGO É DO SISTEMA DE TELEVISÃO BRASILEIRO (SBT)*****" << endl;	   
	cout << ">> Digite a palavra sair para voltar."<< endl;
	cin >> sair;
	iniciar();
}

void jogo(){
	int vez = 0;
    int pontuacao_rodada_j1 = 0;
    int pontuacao_rodada_j2 = 0;
    int pontuacao_rodada_j3 = 0;
    while(jogadores[0].pontuacao != 10000 || jogadores[1].pontuacao != 10000){
        if(vez == 0){
            rodada(jogadores[0], pontuacao_rodada_j1);
            vez = 1;
        }
        else if(vez == 1){
            rodada(jogadores[1], pontuacao_rodada_j2);
            vez = 2;
        }
        else{
            rodada(jogadores[2], pontuacao_rodada_j3);
            vez = 0;
        }
    }
}

int girar_roleta(){
    return rand()% (11-0) + 0;
}

void jogada(Jogador j, int & p_rodada) {
	char letra;
    int r_roleta = 0;
    cout << j.nome << ", pressione ENTER para girar a roleta" << endl;
    scanf("%*c");
    scanf("%*c");
    r_roleta = girar_roleta();
    cout << "Rodando..."<< endl;
    sleepcp(3000);
    if(r_roleta == 10){
        cout << "Passou a vez" << endl;
    }
    else if(r_roleta == 11){
        p_rodada = 0;
        cout << "Perdeu tudo" << endl;
    }else{
        cout << "Valendo " << roleta[r_roleta] << " pontos, digite uma letra:" << endl;
        cin >> letra;
    }
}

void jodada_do_bot(Jogador j, int & p_rodada) {
    int r_roleta = 0;
    cout << "Vez do(a) "<< j.nome << " girar a roleta" << endl;
    cout << "Rodando..."<< endl;
    sleepcp(3000);
    cout << "Valendo " << roleta[r_roleta] << " pontos" << endl;
}

void rodada(Jogador & j, int & p_rodada) {
    if(j.nome == "Bot 01") {
		jodada_do_bot(j, p_rodada);
	}
    else if(j.nome == "Bot 02") {
		jodada_do_bot(j, p_rodada);
    } 
    else {
		jogada(j, p_rodada);
	}
}

int main() {
    srand((unsigned)time(NULL)) ;
    iniciar();
    jogo();
    return 0;
}
