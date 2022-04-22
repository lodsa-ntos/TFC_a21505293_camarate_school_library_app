# Camarate School Library

Aplicação android para permitir a eficiência na requisição de livros de uma biblioteca escolar, com o intuito em apoiar e fortalecer o projeto pedagógico das escolas. O objetivo é ajudar alunos e professores a encontrem livros sem complicações, em que só precisam inserir o título do livro ou o autor para acessar uma lista de livros relevantes para sua consulta de pesquisa, bem como fazer registros de empréstimos de livros e ser alertado sobre o fim para a devolução.

# Como utilizar a aplicação

> Passo 1 - Download e instalar o SDK Flutter

   - Primeiramente, será necessário criar uma pasta chamada "src" no computador de forma a cumprir este diretório [C:\src\flutter] para o local de instalação do SDK Flutter.

   - De seguida, deverão entrar no site do flutter, "[aqui](https://docs.flutter.dev/get-started/install/windows)", para fazer o download e obter a versão estável mais recente do SDK Flutter.

   - Depois do download, é descompactar o ficheiro zip e de seguida colocar a pasta flutter do ficheiro zip dentro da pasta "src".

> Passo 2 - Definir o caminho do flutter como variável de ambiente do sistema

   - Aqui deverá ir no menu iniciar do computador e procurar por "variáveis de ambiente do sistema"

   - Seguidamente, deverá escolher no ecrã de propriedades do sistema a opção com o nome "Variáveis de ambiente".

   ![Alt text](assets/images/outros/propriedades_do_sistema.png?raw=true "Propriedades do sistema")

   - Após definir o caminho do SDK Flutter, verificamos se estes primeiros passos correram bem, para isso, abrimos o cmd e corremos o "flutter doctor", que deverá dizernos se existe uma versão do flutter já instalada no sistema.

   ![Alt text](assets/images/outros/cmd.png?raw=true "Cmd")


> Passo 3 - Download e instalar o JDK 8 - Java SE Development Kit 8u202

   - Em primeiro lugar, deverá ir no site do Java, "[aqui](https://www.oracle.com/pt/java/technologies/javase/javase8-archive-downloads.html)" e fazer o download do JDK 8 da versão Windows x64

   ![Alt text](assets/images/outros/jdk8.png?raw=true "JDK8")

   - Após o isso, deverá definir o caminho do JAVA como variável de ambiente do sistema

   - Deverá ir no menu iniciar do computador e procurar por "variáveis de ambiente do sistema"

   - Depois, deverá escolher no ecrã de propriedades do sistema a opção com o nome "Variáveis de ambiente", tal como o passo anterio com o Flutter.

   - Na janela a seguir, nas opções abaixo, deverá clicar no botão novo e de seguida preencer os cmpos, com os seguintes dados:
        ```
        Nome da variavel: JAVA_HOME
        Valor da variável: C:\Program Files (x86)\Java\jre1.8.0_311
        ```
 ![Alt text](assets/images/outros/java_home.png?raw=true "java_home")   
