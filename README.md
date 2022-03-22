# Para fazer Login

E-mail: teste@gmail.com

Pass: 12345678

# Camarate School Library

A new Flutter project...


# Como o provider está a ser aplicado

### Requisitar livro

Quando um utilizador clicar em cima de um dos livros na página Home, em que esses livros estão presentes na lista de livros prateleiras, o utilizador é redicionado para a página de detalhes desse livro, onde encontrará um botão, do qual, vai estar dipsonível caso o livro ainda tenha sido requisitado. 

Devemos especificar o tipo de modelo que queremos acessar. Nesse caso, queremos LivroRequisitadoModel, então escrevemos Consumer<LivroRequisitadoModel>, para que o pacote do providor ajudar a reconstruir. O provedor é baseado em tipos e, sem o tipo, ele não sabe o que desejamos. O único argumento obrigatório do widget Consumer é o construtor. Builder é uma função que é chamada sempre que o ChangeNotifier é alterado, ousej, quando o utilizador ao clicar no botão para requisitar chama o notifyListeners() do modelo, e desta forma, todos os métodos construtores de todos os widgets Consumer correspondentes são chamados... 
ps: sofrerá alterações mais a frente

![Alt text](assets/images/arq/requisicaoProvider.png?raw=true "Requisitar livro")


O mesmo acontece na devolução do livro....
### Devolver livro
![Alt text](assets/images/arq/devolucaoProvider.png?raw=true "Devolver livro")