# Eu Quero Carros

Desafio teste envolvendo um listagem de carros e a sinalização de interesse através de reservas.

### Arquitetura
- De início pensei em seguir com um MVC simples, mas pensando no futuro do projeto e principalmente em escalabilidade, escolhi a Clean Architecture seguindo os ensinamentos do livro, e adaptando para as necessidades e particularidades do Flutter.
  &emsp;`lib/core`: trata-se de um diretório onde serão armazenados itens de uso comum a todas ou mais de de uma feature.
  &emsp;`lib/features`: trata-se de um diretório onde serão armazenados as features do projeto. É aqui que ficará as funcionalidades do app. Por exemplo, se quisermos adicionar um sistema de pagamento, um clube de assinatura, um marketplace... enfim, cada funcionalidade deve ficar separada e deve ser independente uma da outra. Um exemplo pratico disso é o App da Nubank: a parte de cartão de créditos, de investimentos e de compras são funcionalidades que são independentes, mas se encontram no mesmo app.
  &emsp;&emsp;`features/data`: aqui é armazenado tudo que for relacionado a dados, ou seja, CRUD, o banco de dados em si, models... tudo isso fica na camada de data que é única para cada feature.
  &emsp;&emsp;`features/presentation`: aqui é armazenado tudo que for relacionado ao visual, ou seja, as páginas, os widgets e também o seu respectivo gerenciador de estados.

### Linguagem
- Utilizei o Flutter na última versão disponível no momento de desenvolvimento desse projeto:
- Flutter: `3.19.3` (channel stable).
- Dart: `3.3.1`.

### Gerenciamento de estado e pacotes
- Optei por utilizar o `Bloc`. Tanto pela sua ótima performance, escalabilidade, tempo de desenvolvimento e preferência pessoal.
- Os demais pacotes foram utilizados conforme a necessidade.


### Considerações finais
- O app foi feito em aproximadamente 16h durante o fim de semana dos dias 09 e 10 de março de 2024.


## Sugestão de melhorias (para o futuro)
- Seria interessante ter uma página de perfil, com foto, e mais informações como telefone, endereço... de forma que ao clicar no card de carros, seja possivel reaproveitar essas inforamações automaticamente.
- Devido ao prazo e também ao escopo do projeto não julguei como necessário, mas seria interessante adicionar internacionalização `i18n`.
- A arquitetura da aplicação permite a criação de testes unitários (de unidade) e de widget com relativa facilidade, seria um incremento interessante.