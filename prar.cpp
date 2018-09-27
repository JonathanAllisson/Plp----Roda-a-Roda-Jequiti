#include <bits/stdc++.h>
#include <unistd.h>

using namespace std;

struct Jogador {
    string nome;
    int pontuacao;
};

struct Palavra {
    string palavra;
    string palavra_coberta;
};

Jogador jogadores[3];
Palavra palavraDaVez;
string temas[5] = {"Geografia"};
string letrasOcorridas = "";
string sair;
char letra;
char vogalRF;
char consoantesRF[4] = {'$', '$', '$', '$'};
string opcao;
string entrada;
string tema_escolhido;
string QtdRodadas;
int rodadas = 7;
bool continuar = true;
bool palavraCompleta = false;
string vogais = "aeiou";
string consoantes = "bcdfghjklmnpqrstvwxyz";
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
void digiteConsoante();
void jogo();
void rodadaFinal();
void sleepcp(int ms);
void opcaoInvalida(int escolha);
void case1();
void sorteia_palavra();
void escolherTema();
void escolherQtdRodadas();
void case2();
void novoJogo();
void case3();
void digiteVogal();
void arquivo(int j);
void rodada(Jogador &j, int &p_rodada);
void jodada_do_bot(Jogador j, int & p_rodada);
void jogada(Jogador j, int & p_rodada);

void sleepcp(int ms) {// Cross-platform sleep function
    #ifdef WIN32
        Sleep(ms);
    #else
        usleep(ms * 1000);
    #endif // win32
}

void limparTela() {
	#ifdef WINDOWS
		system("cls");
	#else
		system("clear");
	#endif
}

void opcaoInvalida(int escolha) {
    cout << "***********************************************************************" << endl;
    cout << "--------------------------- OPCÃO INVÁLIDA ----------------------------" << endl;
    cout << "***********************************************************************" << endl;
    sleepcp(1000);
    limparTela();
    if(escolha == 1) {
        case1();
    } else if (escolha == 2) {
        case2();
    } else if (escolha == 3) {
        escolherQtdRodadas();
    } else if (escolha == 4) {
        case3();
    } else if (escolha == 5) {
        digiteVogal();
    } else {
        digiteConsoante();
    }
}

void case3() {
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
            opcaoInvalida(4);
    }
}

void case2(){
    escolherTema();
    limparTela();
    switch(tema_escolhido[0]){
        case '1':
            escolherQtdRodadas();
            break;
        default:
            opcaoInvalida(2);
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
			regras();
            break;
        case '3':
            cout << "Ranking em construção" << endl;
            break;
        default:
            opcaoInvalida(1);
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
	sleepcp(1000);	
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

void escolherQtdRodadas(){
	cout << "-----------------------------------------------------------------------" << endl;
    cout << "********************* RODA A RODA JEQUITI *****************************" << endl;
    cout << "-------------------------  3 Rodadas ----------------------------------" << endl;
    cout << "-------------------------  5 Rodadas ----------------------------------" << endl;
    cout << "------------------------- 10 Rodadas ----------------------------------" << endl;
    cout << "***********************************************************************" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "																		" << endl;
    cout << ">> Quantas rodadas? " << endl;
	cin >> QtdRodadas;
    if(QtdRodadas != "10" && QtdRodadas != "3" && QtdRodadas != "5") {
        limparTela();
        opcaoInvalida(3);
    }
    rodadas = stoi(QtdRodadas);
	limparTela();
    case3();
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

void novoJogo() {
    palavraDaVez.palavra = "";
    palavraDaVez.palavra_coberta = "";
    letrasOcorridas = "";
    sorteia_palavra();
    palavraCompleta = false;
}

void jogo(){
	int vez = 0;
    int pontuacao_rodada_j1 = 0;
    int pontuacao_rodada_j2 = 0;
    int pontuacao_rodada_j3 = 0;
    while(rodadas > 0) {
        rodadas -= 3;
        novoJogo();
        while(!palavraCompleta) {
            continuar = true;
            if (vez == 0) {
                while(continuar) {
	                cout << "**************************** PONTUAÇÃO ********************************" << endl;
                    cout << jogadores[0].nome << ": " << pontuacao_rodada_j1 << " // "<< jogadores[1].nome << ": " << pontuacao_rodada_j2 << " // "<< jogadores[2].nome << ": " << pontuacao_rodada_j3 << endl;
                    cout << "***********************************************************************" << endl;
                    rodada(jogadores[0], pontuacao_rodada_j1);
                }
                vez = 1;
            } else if (vez == 1) {
                while(continuar) {
                    cout << "**************************** PONTUAÇÃO ********************************" << endl;
                    cout << jogadores[0].nome << ": " << pontuacao_rodada_j1 << " // "<< jogadores[1].nome << ": " << pontuacao_rodada_j2 << " // "<< jogadores[2].nome << ": " << pontuacao_rodada_j3 << endl;
                    cout << "***********************************************************************" << endl;
                    rodada(jogadores[1], pontuacao_rodada_j2);
                }
                vez = 2;
            } else {
                while(continuar) {
                    cout << "**************************** PONTUAÇÃO ********************************" << endl;
                    cout << jogadores[0].nome << ": " << pontuacao_rodada_j1 << " // "<< jogadores[1].nome << ": " << pontuacao_rodada_j2 << " // "<< jogadores[2].nome << ": " << pontuacao_rodada_j3 << endl;
                    cout << "***********************************************************************" << endl;
                    rodada(jogadores[2], pontuacao_rodada_j3);
                }
                vez = 0;
            }
        }
        jogadores[0].pontuacao += pontuacao_rodada_j1;
        jogadores[1].pontuacao += pontuacao_rodada_j2;
        jogadores[2].pontuacao += pontuacao_rodada_j3;
        cout << "-----------------------------------------------------------------------" << endl;
	    cout << "************************* PONTUAÇÃO GERAL *****************************" << endl;
        cout << "-----------------------------------------------------------------------" << endl;
        cout << "-> Pontuação do(a) jogador(a) " << jogadores[0].nome << ": " << jogadores[0].pontuacao << endl;
        cout << "-> Pontuação do(a) jogador(a) " << jogadores[1].nome << ": " << jogadores[1].pontuacao << endl;
        cout << "-> Pontuação do(a) jogador(a) " << jogadores[2].nome << ": " << jogadores[2].pontuacao << endl;
        cout << "Aperte ENTER para continuar." << endl;
        pontuacao_rodada_j1 = 0;
        pontuacao_rodada_j2 = 0;
        pontuacao_rodada_j3 = 0;
        scanf("%*c");
        scanf("%*c");
        limparTela();
    }
    int pontuacaoJogadorFinal = max(jogadores[0].pontuacao, max(jogadores[1].pontuacao, jogadores[2].pontuacao));
    for (int i = 0; i < 3; i++) {
        if (jogadores[i].pontuacao == pontuacaoJogadorFinal) {
            cout << "-----------------------------------------------------------------------" << endl;
            cout << "************************** RODADA FINAL *******************************" << endl;
            cout << "-----------------------------------------------------------------------" << endl;
            cout << jogadores[i].nome << ", aperte ENTER para continuar." << endl;
            scanf("%*c");
            scanf("%*c");
            limparTela();
            rodadaFinal();
        }
    }
}

void rodadaFinal() {
    digiteVogal();
    limparTela();
    for (int i = 0; i < 4; i++) {
        digiteConsoante();
        limparTela();
    }
    cout << vogalRF << endl;
    for (int i = 0; i < 4; i++) {
        cout << consoantesRF[i] << endl;
    }
    sleepcp(5000);
}

void digiteConsoante() {
    char temp;
    cout << "Digite uma consoante: ";
    cin >> temp;
    bool correto = false;
    for (int i = 0; i < 21; i++) {
        if(temp == consoantes[i]) {
            correto = true;
        }
        for (int j = 0; j < 4; j++) {
            if(temp == consoantesRF[j]) {
                correto = false;
            }
        }
    }
    if(!correto) {
        limparTela();
        opcaoInvalida(6);
    } else {
        int i = 0;
        bool aux = true;
        while(i < 4 && aux) {
            if (consoantesRF[i] == '$') {
                consoantesRF[i] = temp;
                aux = false;
            }
            i++;
        }
    }
}

void digiteVogal() {
    cout << "Digite uma vogal: ";
    cin >> vogalRF;
    bool correto = false;
    for (int i = 0; i < 5; i++) {
        if (vogalRF == vogais[i]) {
            correto = true;
        }
    }
    if(!correto) {
        limparTela();
        opcaoInvalida(5);
    }
}

int sortear_numero(int n_maximo){
    return rand() % n_maximo;
}

void sorteia_palavra(){
    if (tema_escolhido == "1"){
        int tmp = sortear_numero(20);
        if(tmp % 2 == 0) {
            tmp++;
        }
        arquivo(tmp);
    }
}

void jogada(Jogador j, int & p_rodada) {
    int r_roleta = 0;
    cout << "Tema: " << temas[stoi(tema_escolhido) - 1] << endl;
    cout << palavraDaVez.palavra_coberta << endl;
    cout << letrasOcorridas << endl;
    cout << j.nome << ", pressione ENTER para girar a roleta" << endl;
    scanf("%*c");
    scanf("%*c");
    r_roleta = sortear_numero(20);
    cout << "Rodando..."<< endl;
    sleepcp(1000);
    if(r_roleta == 19){
        cout << "Passou a vez" << endl;
        sleepcp(2000);
        continuar = false;
    } else if(r_roleta == 20){
        p_rodada = 0;
        cout << "Perdeu tudo" << endl;
        sleepcp(2000);
        continuar = false;
    } else{
        cout << "Valendo " << roleta[r_roleta] << " pontos, digite uma letra:" << endl;
        cin >> letra;
        letra = toupper(letra);
        int count = 0;
        bool letraJaOcorrida = false;
        for (int i = 0; i <= letrasOcorridas.size(); i++) {
            if(toupper(letra) == letrasOcorridas[i]) {
                letraJaOcorrida = true;
            }
        }
        if(!letraJaOcorrida) {
            for (int i = 0; i < palavraDaVez.palavra_coberta.size(); i++) {
                if(palavraDaVez.palavra[i] == toupper(letra)) {
                    count++;
                    palavraDaVez.palavra_coberta[i] = palavraDaVez.palavra[i];
                }
            }
            if(count != 0) {
                int temp = stoi(roleta[r_roleta]) * count;
                cout << "Você acertou " << count << " letras e ganhou " << (temp) << " pontos!" << endl;
                p_rodada += temp;
                letrasOcorridas += (toupper(letra));
                sleepcp(2000);
            } else {
                cout << "Você não acertou nenhuma letra da palavra." << endl;
                sleepcp(2000);
                continuar = false;
            }
        } else {
            cout << "Letra já escolhida, você perdeu a vez!" << endl;
            sleepcp(2000);
            continuar = false;
        }
        palavraCompleta = true;
        for (int i = 0; i < palavraDaVez.palavra_coberta.size(); i++) {
            if(palavraDaVez.palavra[i] != palavraDaVez.palavra_coberta[i]) {
                palavraCompleta = false;
            }
        }
        if(palavraCompleta) {
            continuar = false;
        }
    }
    limparTela();
}

void jodada_do_bot(Jogador j, int & p_rodada) {
    int r_roleta = 0;
    cout << "Tema: " << tema_escolhido << endl;
    cout << palavraDaVez.palavra << endl;
    cout << "Vez do "<< j.nome << " girar a roleta" << endl;
    cout << "Rodando..."<< endl;
    sleepcp(1000);
    cout << "Valendo " << roleta[r_roleta] << " pontos" << endl;
    sleepcp(1000);
    limparTela();
}

void rodada(Jogador & j, int & p_rodada) {
    if(j.nome == "Bot 01" || j.nome == "Bot 02") {
		jodada_do_bot(j, p_rodada);
	} else {
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
            palavraDaVez.palavra = Linha;
            for (int k = 0; k < (palavraDaVez.palavra.size() - 1); k++) {
                if (palavraDaVez.palavra[i] == ' ') {
                    palavraDaVez.palavra_coberta += " ";
                } else {
                    palavraDaVez.palavra_coberta += "#";
                }
            }
            palavraDaVez.palavra[palavraDaVez.palavra.size() - 1] = '\0';
        }
        i++;
    }

    fclose(arq);
}

int main() {
    srand((unsigned)time(NULL));
    iniciar();
    jogo();
    return 0;
}
