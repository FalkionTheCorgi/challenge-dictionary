# Desafio Dicionário

## Sobre

- [Breve Descrição](#breve-descrição)
- [Tecnologias](#tecnologias)
- [Como Utilizo o Projeto?](#como-utilizo-o-projeto)
- [Obrigatórios](#obrigatórios)
- [Diferenciais](#diferenciais)
- [Créditos](#créditos)

## [Breve Descrição](#sobre)

Esse desafio tem como objetivo, de maneira sucinta, criar um aplicativo que apresente diversas palavras que ao interagir com elas mostre o seu significado e sua forma de pronuncia e significado
caso existam.

## [Tecnologias](#sobre)

Esse aplicativo utilizou as seguintes tecnologias:

- Flutter
- Dart
- [Sqflite](https://pub.dev/packages/sqflite)
- [Riverpod](https://pub.dev/packages/riverpod)
- [Http](https://pub.dev/packages/http)
- [WordsApi](https://www.wordsapi.com/)

## [Como Utilizo o Projeto?](#sobre)

- Faça o download ou clone o projeto.
- Adquira duas credenciais para acesso ao WordsApi, acesse o site para instruções de como fazer.
- Na raiz do projeto crie um arquivo json com nome "env.local.json".
- Crie duas chaves dentro desse json, uma com o nome "X_RapidApi_Key", e a outra com o nome "X_RapidAPI_Host".
- Se todas as suas credenciais estiverem corretas, execute o projeto no terminal usando:
```sh
flutter run --dart-define-from-file=env.local.json
```

## [Obrigatórios](#sobre)

- [x] Como usuário, devo ser capaz de visualizar uma lista de palavras com rolagem infinita
- [x] Como usuário, devo ser capaz de visualizar uma palavra, significados e a fonética
- [x] Como usuário, devo ser capaz de salvar a palavra como favorito
- [x] Como usuário, devo ser capaz de remover a palavra como favorito
- [x] Como usuário, devo ser capaz de visitar uma lista com as palavras que já vi anteriormente
- [x] A API não possui endpoint com a lista de palavras. Essa lista pode ser carregada em memória ou ser salva em banco de dados local ou remoto
- [x] Salvar em cache o resultado das requisições ao Words API, para agilizar a resposta em caso de buscas com parâmetros repetidos.
- [x] Seguir o wireframe para a página de listagem dos dados. Pode-se alterar a posição dos itens, mantendo as funcionalidades solicitadas.
    - ![wireframe](img/wireframe.png)

## [Diferenciais](#sobre)

- [ ] Implementar um tocador de audio.
- [x] Utilizar alguma ferramenta de Injeção de Dependência.
- [ ] Escrever Unit Tests ou E2E Test.
- [ ] Implementar login com usuário e senha e associar os favoritos e histórico ao ID do usuário, salvando essa informação em banco de dados local ou remoto.

## [Créditos](#sobre)

Esse desafio foi disponibilizado pela [Coodesh](https://coodesh.com/) 

