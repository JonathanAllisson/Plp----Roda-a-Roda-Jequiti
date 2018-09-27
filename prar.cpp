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
string opcao;
string entrada;
string tema_escolhido;
string QtdPalavras;
int palavras;
int n_rodada = 0;
bool palavraSorteada = false;
bool continuar = true;
string palavrasSorteadas = "";
string roleta[21] = {"100","150","200","250","300","350","400","450","500","550","600","650","700","750","800","850","900","950","1000","Passou a vez","Perdeu tudo"};
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
void case4();
void sorteia_palavra();
void escolherTema();
void escolherQtdPalavras();
void case2();
void case3();
void opcaoInvalida2();
void arquivo(int j);
struct Jogador{
    string nome;
    int pontuacao;
};

struct Palavra{
    string palavra;
    string palavra_coberta;
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
		system("cls");
	#else
		system("clear");
	#endif
}

void opcaoInvalida(bool escolha) {
    cout << "***********************************************************************" << endl;
    cout << "--------------------------- OPCÃO INVÁLIDA ----------------------------" << endl;
    cout << "***********************************************************************" << endl;
    sleepcp(1000);
    limparTela();
    if(escolha) {
        case1();
    } else {
        case4();
    }
}

void opcaoInvalida2(bool escolha) {
    cout << "***********************************************************************" << endl;
    cout << "--------------------------- OPCÃO INVÁLIDA ----------------------------" << endl;
    cout << "***********************************************************************" << endl;
    sleepcp(1000);
    limparTela();
    if(escolha) {
        case2();
    } else {
        case3();
    }
}

void case4() {
    comecar();
    limparTela();
    switch(entrada[0]){
        case '1':
            umJogador();
            break;
        case '2':
            doisJogadores();
            break;
        case '3':
            tresJogadores();
            break;
        default:
            opcaoInvalida(false);
    }
}

void case3(){
    escolherQtdPalavras();
    limparTela();
    switch(QtdPalavras[0]){
        case '3':
            case4();
            break;
        case '5':
            case4();
            break;
        case '1':
            case4();
            break;
        default:
            opcaoInvalida2(false);
    }
}

void case2(){
    escolherTema();
    limparTela();
    switch(tema_escolhido[0]){
        case '1':
            case3();
            break;
        default:
            opcaoInvalida2(true);
    }

}

void case1() {
    telaOpcoes();
    limparTela();
    switch(opcao[0]){
        case '1':
            case2();
            break;
        case '2':
            cout << opcao << endl;
			regras();
            break;
        case '3':
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

void escolherTema(){
	cout << "-----------------------------------------------------------------------" << endl;
    cout << "********************* RODA A RODA JEQUITI *****************************" << endl;
    cout << "-------------------------  Geografia 1  -------------------------------" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "***********************************************************************" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "																		" << endl;
    cout << ">> Qual a sua escolha? " << endl;
	cin >> tema_escolhido;
	limparTela();
}

void escolherQtdPalavras(){
	cout << "-----------------------------------------------------------------------" << endl;
    cout << "********************* RODA A RODA JEQUITI *****************************" << endl;
    cout << "-------------------------  3 Palavras ---------------------------------" << endl;
    cout << "-------------------------  5 Palavras ---------------------------------" << endl;
    cout << "------------------------- 10 Palavras ---------------------------------" << endl;
    cout << "***********************************************************************" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "																		" << endl;
    cout << ">> Quantas palavras ? " << endl;
	cin >> QtdPalavras;
    palavras = atoi(QtdPalavras.c_str());
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
    limparTela();
	case1();
}

void jogo(){
	int vez = 0;
    int pontuacao_rodada_j1 = 0;
    int pontuacao_rodada_j2 = 0;
    int pontuacao_rodada_j3 = 0;
    while(n_rodada < 6){
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

int girar_roleta(int n_maximo){
    return rand()% n_maximo;
}
void sorteia_palavra(string tema_escolhido){
    palavras-= 1;
    if(palavras ==0){
        continuar = false;
    }
    if (tema_escolhido == "1"){
        arquivo(rand()% 10 + 1);
    }
    
}

void jogada(Jogador j, int & p_rodada) {
	char letra;
    int r_roleta = 0;
    cout << "Tema: " << tema_escolhido << endl;
    cout << palavrasSorteadas<< endl;
    cout << j.nome << ", pressione ENTER para girar a roleta" << endl;
    scanf("%*c");
    scanf("%*c");
    r_roleta = girar_roleta(20);
    cout << "Rodando..."<< endl;
    sleepcp(3000);
    if(r_roleta == 19){
        cout << "Passou a vez" << endl;
    }
    else if(r_roleta == 20){
        p_rodada = 0;
        cout << "Perdeu tudo" << endl;
    }else{
        cout << "Valendo " << roleta[r_roleta] << " pontos, digite uma letra:" << endl;
        cin >> letra;
    }
    limparTela();
}

void jodada_do_bot(Jogador j, int & p_rodada) {
    int r_roleta = 0;
    cout << "Tema: " << tema_escolhido << endl;
    cout << palavrasSorteadas<< endl;
    cout << "Vez do "<< j.nome << " girar a roleta" << endl;
    cout << "Rodando..."<< endl;
    sleepcp(3000);
    cout << "Valendo " << roleta[r_roleta] << " pontos" << endl;
    sleepcp(2000);
    limparTela();
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

void arquivo(int j) {
    FILE *arq;
    char Linha[100];
    int i = 0;
    char *result;
    limparTela();

    arq = fopen("palavrasedicas.txt", "rt");

    if (arq == NULL) {
        printf("Problemas na abertura do arquivo\n");
        return;
    }

    while (!feof(arq)) {
        result = fgets(Linha, 100, arq);
        if (i==j) {
            palavrasSorteadas = Linha;
        }
        i++;
    }

    fclose(arq);
}

int main() {
    srand((unsigned)time(NULL));
    iniciar();
     do {
         sorteia_palavra(tema_escolhido);
         jogo();
    } while (continuar);
    return 0;
}
