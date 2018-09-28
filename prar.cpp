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
    string dica;
};

Jogador jogadores[3];
Palavra palavraDaVez;
char palavrasJaFoi[10] = {'$', '$', '$', '$', '$', '$', '$', '$', '$', '$'};
string temas[5] = {"Geografia", "Marcas", "Filmes"};
string letrasOcorridas = "";
string letrasDiferentes = "EIUCHFRJNPMQS";
string sair;
char chute;
char letra;
char vogalRF;
char consoantesRF[4] = {'$', '$', '$', '$'};
string opcao;
string entrada;
string tema_escolhido;
string QtdRodadas;
string palavraCorreta;
int rodadas = 7;
bool continuar = true;
bool palavraCompleta = false;
string vogais = "AEIOU";
string consoantes = "BCDFGHJKLMNPQRSTVWXYZ";
string roleta[21] = {"100","150","200","250","300","350","400","450","500","550","600","650","700","750","800","850","900","950","1000","Passou a vez","Perdeu tudo"};

char chutaLetra();
void telaInicial();
void iniciar();
void limparTela();
void telaOpcoes();
void comecar();
void umJogador();
void jogarNovamente();
void doisJogadores();
void tresJogadores();
void regras();
void digiteConsoante();
void jogo();
void mostraLetrasCertas(Jogador finalista);
int main();
void rodadaFinal(Jogador finalista);
void sleepcp(int ms);
void gerandoLetrasBot();
void opcaoInvalida(int escolha);
void jogandoPalavra(int r_roleta, int & p_rodada);
void jogandoPalavraBot(int r_roleta, int & p_rodada);
void case1();
void sorteia_palavra();
int rodandoRoleta();
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
    } else if (escolha == 6) {
        digiteConsoante();
    } else {
        jogarNovamente();
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
        case '2':
            escolherQtdRodadas();
            break;
        case '3':
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
    cout << "--------------------------  Marcas 2  ---------------------------------" << endl;
    cout << "---------------------------  Filmes 3  --------------------------------" << endl;
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
    int countRodada = 0;
	int vez = 0;
    int pontuacao_rodada_j1 = 0;
    int pontuacao_rodada_j2 = 0;
    int pontuacao_rodada_j3 = 0;
    while(countRodada < rodadas) {
        countRodada += 1;
        novoJogo();
        gerandoLetrasBot();
        while(!palavraCompleta) {
            continuar = true;
            if (vez == 0) {
                while(continuar) {
                    cout << "-> Rodada N°: " << countRodada << endl;
	                cout << "**************************** PONTUAÇÃO ********************************" << endl;
                    cout << jogadores[0].nome << ": " << pontuacao_rodada_j1 << " // "<< jogadores[1].nome << ": " << pontuacao_rodada_j2 << " // "<< jogadores[2].nome << ": " << pontuacao_rodada_j3 << endl;
                    cout << "***********************************************************************" << endl;
                    rodada(jogadores[0], pontuacao_rodada_j1);
                }
                vez = 1;
            } else if (vez == 1) {
                while(continuar) {
                    cout << "-> Rodada N°: " << countRodada << endl;
                    cout << "**************************** PONTUAÇÃO ********************************" << endl;
                    cout << jogadores[0].nome << ": " << pontuacao_rodada_j1 << " // "<< jogadores[1].nome << ": " << pontuacao_rodada_j2 << " // "<< jogadores[2].nome << ": " << pontuacao_rodada_j3 << endl;
                    cout << "***********************************************************************" << endl;
                    rodada(jogadores[1], pontuacao_rodada_j2);
                }
                vez = 2;
            } else {
                while(continuar) {
                    cout << "-> Rodada N°: " << countRodada << endl;
                    cout << "**************************** PONTUAÇÃO ********************************" << endl;
                    cout << jogadores[0].nome << ": " << pontuacao_rodada_j1 << " // "<< jogadores[1].nome << ": " << pontuacao_rodada_j2 << " // "<< jogadores[2].nome << ": " << pontuacao_rodada_j3 << endl;
                    cout << "***********************************************************************" << endl;
                    rodada(jogadores[2], pontuacao_rodada_j3);
                }
                vez = 0;
            }
        }
        if(palavraCompleta) {
            if(vez == 0) {
                cout << "-----------------------------------------------------------------------" << endl;
                cout << "-> PARABÉNS, " << jogadores[2].nome << " ACERTOU!!!" << endl;
                cout << "-----------------------------------------------------------------------" << endl;
                sleepcp(2000);
                limparTela();
                jogadores[2].pontuacao += pontuacao_rodada_j3;
            } else if(vez == 1) {
                cout << "-----------------------------------------------------------------------" << endl;
                cout << "-> PARABÉNS, " << jogadores[0].nome << " ACERTOU!!!" << endl;
                cout << "-----------------------------------------------------------------------" << endl;
                sleepcp(2000);
                limparTela();
                jogadores[0].pontuacao += pontuacao_rodada_j1;
            } else if (vez == 2) {
                cout << "-----------------------------------------------------------------------" << endl;
                cout << "-> PARABÉNS, " << jogadores[1].nome << " ACERTOU!!!" << endl;
                cout << "-----------------------------------------------------------------------" << endl;
                sleepcp(2000);
                limparTela();
                jogadores[1].pontuacao += pontuacao_rodada_j2;
            }
        }
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
            if (jogadores[i].nome != "Bot 01" && jogadores[i].nome != "Bot 02") {
                novoJogo();
                cout << "-----------------------------------------------------------------------" << endl;
                cout << "************************** RODADA FINAL *******************************" << endl;
                cout << "-----------------------------------------------------------------------" << endl;
                cout << "Tema: " << temas[stoi(tema_escolhido) - 1] << endl;
                cout << "Dica: " << palavraDaVez.dica << endl;
                cout << palavraDaVez.palavra_coberta << endl;
                cout << jogadores[i].nome << ", aperte ENTER para continuar." << endl;
                scanf("%*c");
                scanf("%*c");
                limparTela();
                rodadaFinal(jogadores[i]);
            } else {
                cout << jogadores[i].nome << " GANHOU!" << endl;
                sleepcp(3000);
            }
        }
    }
    jogarNovamente();
}

void jogarNovamente() {
    char jogarNovamente;
    cout << "Deseja jogar novamente? (y/n)" << endl;
    cin >> jogarNovamente;
    if(toupper(jogarNovamente) == 'Y') {
        main();
    } else if (toupper(jogarNovamente) != 'N') {
        opcaoInvalida(7);
    }
}

void gerandoLetrasBot() {;
    for (int k = 0; k < (palavraDaVez.palavra.size() - 1); k++) {
        bool esta = false;
        for (int j = 0; j < letrasDiferentes.size(); j++) {
            if(palavraDaVez.palavra[k] == letrasDiferentes[j]){
                esta = true;;
            }
        }
        if(!esta) {
            letrasDiferentes += palavraDaVez.palavra[k];
        }
    }
}

void rodadaFinal(Jogador finalista) {
    digiteVogal();
    limparTela();
    for (int i = 0; i < 4; i++) {
        digiteConsoante();
        limparTela();
    }
    mostraLetrasCertas(finalista);
}

void tirar(char t) {
    for (int i = 0; i < palavraDaVez.palavra_coberta.size(); i++) {
        if(palavraDaVez.palavra[i] == toupper(t)) {
            palavraDaVez.palavra_coberta[i] = palavraDaVez.palavra[i];
        }
    }
}

void mostraLetrasCertas(Jogador finalista) {
    string rfinal[5] = {"vogal", "primeira consoante", "segunda consoante", "terceira consoante", "quarta consoante"};
    cout << "Palavra escondida" << endl;
    cout << palavraDaVez.palavra_coberta << endl;
    sleepcp(2000);
    for (int i = 0; i < 5; i++) {
        cout << "Mostrando sua " << rfinal[i] << ":" << endl;
        if(i == 0) {
            tirar(vogalRF);
        } else {
            tirar(consoantesRF[i-1]);
        }
        cout << palavraDaVez.palavra_coberta << endl;
        sleepcp(2000);
    }
    limparTela();
    cout << "Agora tente acertar a palavra e ganhar 1 MILHÃO!!" << endl;
    cin >> palavraCorreta;
    palavraCompleta = true;
    if(palavraCorreta.size() == palavraDaVez.palavra_coberta.size()) {
        for (int i = 0; i < (palavraDaVez.palavra.size() - 1); i++) {
            if(palavraDaVez.palavra[i] != toupper(palavraCorreta[i])) {
                palavraCompleta = false;
            }
        }
    } else {
        palavraCompleta = false;
    }
    continuar = false;
    if(!palavraCompleta) {
        limparTela();
        cout << "QUE PENA, NÃO FOI DESSA VEZ!" << endl;
        cout << finalista.nome << " ganhou: " << finalista.pontuacao << endl;
        sleepcp(3000);
    } else {
        limparTela();
        cout << "-----------------------------------------------------------------------" << endl;
        cout << "***************** VOCÊ GANHOU UM MILHÃO DE REAIS **********************" << endl;
        cout << "-----------------------------------------------------------------------" << endl;
        sleepcp(3000);
    }
    jogarNovamente();
}

void digiteConsoante() {
    char temp;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "************************** RODADA FINAL *******************************" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "Tema: " << temas[stoi(tema_escolhido) - 1] << endl;
    cout << "Dica: " << palavraDaVez.dica << endl;
    cout << "Letras já escolhidas: " << letrasOcorridas << endl;
    cout << palavraDaVez.palavra_coberta << endl;
    cout << "Digite uma consoante: ";
    cin >> temp;
    bool correto = false;
    for (int i = 0; i < 21; i++) {
        if(toupper(temp) == consoantes[i]) {
            correto = true;
         }
        for (int j = 0; j < 4; j++) {
            if(toupper(temp) == consoantesRF[j]) {
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
                consoantesRF[i] = toupper(temp);
                aux = false;
            }
            i++;
        }
        letrasOcorridas += toupper(temp);
        letrasOcorridas += " ";
    }
}

void digiteVogal() {
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "************************** RODADA FINAL *******************************" << endl;
    cout << "-----------------------------------------------------------------------" << endl;
    cout << "Tema: " << temas[stoi(tema_escolhido) - 1] << endl;
    cout << "Dica: " << palavraDaVez.dica << endl;
    cout << "Letras já escolhidas: " << letrasOcorridas << endl;    
    cout << palavraDaVez.palavra_coberta << endl;
    cout << "Digite uma vogal: ";
    cin >> vogalRF;
    bool correto = false;
    for (int i = 0; i < 5; i++) {
        if (toupper(vogalRF) == vogais[i]) {
            correto = true;
        }
    }
    if(!correto) {
        limparTela();
        opcaoInvalida(5);
    } else {
        letrasOcorridas += toupper(vogalRF);
        letrasOcorridas += " ";
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
    } else if (tema_escolhido == "2") {
        int tmp = sortear_numero(20)+20;
        if(tmp % 2 == 0) {
            tmp++;
        }
        arquivo(tmp);
    } else if (tema_escolhido == "3") {
        int tmp = sortear_numero(20)+40;
        if(tmp % 2 == 0) {
            tmp++;
        }
        arquivo(tmp);
    }
}

void jogada(Jogador j, int & p_rodada) {
    cout << "Tema: " << temas[stoi(tema_escolhido) - 1] << endl;
    cout << "Dica: " << palavraDaVez.dica << endl;
    cout << palavraDaVez.palavra_coberta << endl;
    cout << "Letras já escolhidas: " << letrasOcorridas << endl;
    cout << j.nome << ", pressione ENTER para girar a roleta" << endl;
    int r_roleta = rodandoRoleta();
    if(r_roleta == 19){
        cout << "Passou a vez" << endl;
        sleepcp(2000);
        continuar = false;
    } else if(r_roleta == 20){
        p_rodada = 0;
        cout << "Perdeu tudo" << endl;
        sleepcp(2000);
        continuar = false;
    } else {
        jogandoPalavra(r_roleta, p_rodada);
    }
    limparTela();
}

void jogandoPalavra(int r_roleta, int & p_rodada) {
    int c = 0;
    for (int i = 0; i < palavraDaVez.palavra_coberta.size(); i++) {
        if(palavraDaVez.palavra_coberta[i] == '#') {
            c++;
        }
    }
    if (c <= 3) {
        cout << "Valendo " << roleta[r_roleta] << " pontos por letra acertada para completar" << endl;
        cout << "a palavra, digite a palavra corretamente: " << endl;
        cin >> palavraCorreta;
        palavraCompleta = true;
        if(palavraCorreta.size() == palavraDaVez.palavra_coberta.size()) {
            for (int i = 0; i < (palavraDaVez.palavra.size() - 1); i++) {
                if(palavraDaVez.palavra[i] != toupper(palavraCorreta[i])) {
                    palavraCompleta = false;
                }
            }
        } else {
            palavraCompleta = false;
        }
        continuar = false;
        if(!palavraCompleta) {
            limparTela();
            cout << "-----------------------------------------------------------------------" << endl;
            cout << "************************* PALAVRA ERRADA ******************************" << endl;
            cout << "-----------------------------------------------------------------------" << endl;
            sleepcp(3000);
        } else {
            p_rodada += stoi(roleta[r_roleta])*c;
        }
    } else {
        cout << "Valendo " << roleta[r_roleta] << " pontos, digite uma letra:" << endl;
        cin >> letra;
        int count = 0;
        bool letraJaOcorrida = false;
        for (int i = 0; i <= letrasOcorridas.size(); i++) {
            if(toupper(letra) == letrasOcorridas[i]) {
                letraJaOcorrida = true;
            }
        }
        for (int i = 0; i < letrasDiferentes.size(); i++) {
            if(toupper(letra) == letrasDiferentes[i]) {
                letrasDiferentes[i] = '$';
            }
        }
        if(!letraJaOcorrida) {
            letrasOcorridas += toupper(letra);
            letrasOcorridas += " ";
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
    }
}

void jogandoPalavraBot(int r_roleta, int & p_rodada){
    int c = 0;
    for (int i = 0; i < palavraDaVez.palavra_coberta.size(); i++) {
        if(palavraDaVez.palavra_coberta[i] == '#') {
            c++;
        }
    }
    if (c <= 3) {;
        int n;
        n = sortear_numero(6);
        if(n == 0 || n == 3 || n == 4) {
            palavraCompleta = true;
        } else {
            palavraCompleta = false;
        }
        continuar = false;
        if(!palavraCompleta) {
            limparTela();
            cout << "-----------------------------------------------------------------------" << endl;
            cout << "************************* PALAVRA ERRADA ******************************" << endl;
            cout << "-----------------------------------------------------------------------" << endl;
            sleepcp(3000);
        } else {
            p_rodada += stoi(roleta[r_roleta]) * c;
        }
    } else {
        cout << "Valendo " << roleta[r_roleta] << " pontos." << endl;
        int count = 0;
        chute = chutaLetra();
        cout << chute << endl;
        sleepcp(2000);
        bool letraJaOcorrida = false;
        for (int i = 0; i <= letrasOcorridas.size(); i++) {
            if(toupper(chute) == letrasOcorridas[i]) {
                letraJaOcorrida = true;
            }
        } 
        if(!letraJaOcorrida) {
            letrasOcorridas += toupper(chute);
            letrasOcorridas += " ";
            for (int i = 0; i < palavraDaVez.palavra_coberta.size(); i++) {
                if(palavraDaVez.palavra[i] == toupper(chute)) {
                    count++;
                    palavraDaVez.palavra_coberta[i] = palavraDaVez.palavra[i];
                }
            }
            if(count != 0) {
                int temp = stoi(roleta[r_roleta]) * count;
                cout << "Acertou " << count << " letras e ganhou " << (temp) << " pontos!" << endl;
                p_rodada += temp;
                sleepcp(2000);
            } else {
                cout << "Não acertou nenhuma letra da palavra." << endl;
                sleepcp(2000);
                continuar = false;
            }
        } else {
            cout << "Letra já escolhida, perdeu a vez!" << endl;
            sleepcp(2000);
            continuar = false;
        }
    }
}

char chutaLetra(){
    int valor = sortear_numero(letrasDiferentes.length());
    while(letrasDiferentes[valor] == '$') {
        valor = sortear_numero(letrasDiferentes.length());
    }        
    char retorno = letrasDiferentes[valor];
    letrasDiferentes[valor] = '$';
    return retorno;
}

int rodandoRoleta() {
    int r_roleta = 0;
    scanf("%*c");
    scanf("%*c");
    r_roleta = sortear_numero(20);
    cout << "Rodando..."<< endl;
    sleepcp(2000);
    return r_roleta;
}

void jodada_do_bot(Jogador j, int & p_rodada) {
    int r_roleta = 0;
    cout << "Tema: " << temas[stoi(tema_escolhido) - 1] << endl;
    cout << "Dica: " << palavraDaVez.dica << endl;
    cout << palavraDaVez.palavra_coberta << endl;
    cout << "Letras já escolhidas: " << letrasOcorridas << endl;
    cout << "Vez do "<< j.nome << " girar a roleta" << endl;
    cout << "Rodando..."<< endl;
    r_roleta = sortear_numero(20);
    if(r_roleta == 19){
        cout << "Passou a vez" << endl;
        sleepcp(2000);
        continuar = false;
    } else if(r_roleta == 20){
        p_rodada = 0;
        cout << "Perdeu tudo" << endl;
        sleepcp(2000);
        continuar = false;
    } else {
        jogandoPalavraBot(r_roleta, p_rodada);
    }
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
    bool pass = true;
    char ca = j;
    for (int i = 0; i < 10; i++) {
        if (palavrasJaFoi[i] == ca) {
            pass = false;
        }
    }
    if(!pass) {
        sorteia_palavra();
    } else {
        for (int i = 0; i < 10; i++) {
            if (palavrasJaFoi[i] == '$') {
                palavrasJaFoi[i] = ca;
            }
        }

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
            if (i == (j-1)) {
                palavraDaVez.dica = Linha;
                palavraDaVez.dica[palavraDaVez.dica.size() - 1] = '\0';
            } else if (i == j) { 
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
}

int main() {
    srand((unsigned)time(NULL));
    iniciar();
    jogo();
    for (int i = 0; i < 10; i++) {
        if (palavrasJaFoi[i] != '$') {
            palavrasJaFoi[i] = '$';
        }
    }
    return 0;
}
