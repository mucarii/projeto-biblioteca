# Projeto Biblioteca - Gerenciamento de Transações e Backup
Este projeto foi desenvolvido para demonstrar o uso de transações e procedimentos armazenados em um banco de dados MySQL, no contexto de uma biblioteca. O banco de dados gerencia informações sobre livros, estoque e empréstimos, permitindo o controle de operações de forma segura e eficiente.

## Estrutura do Projeto
### 1. Banco de Dados
O banco de dados utilizado é chamado biblioteca e contém as seguintes tabelas:

livros: Contém informações sobre os livros disponíveis na biblioteca, como título, autor, ano de publicação e gênero.
estoque: Gerencia o estoque de cada livro, controlando a quantidade disponível.
emprestimos: Registra os empréstimos de livros realizados pelos leitores, incluindo as datas de empréstimo e devolução.
### 2. Funcionalidades
2.1 Transações
O projeto inclui exemplos de transações que garantem a consistência dos dados durante operações críticas, como o registro de um empréstimo de livro e a atualização do estoque.

### 2.2 Procedure com Transação
Uma PROCEDURE chamada RegistrarEmprestimo foi criada para encapsular a lógica de registro de um empréstimo, incluindo verificações de estoque e rollback em caso de erro.

### 2.3 Backup e Recovery
Instruções são fornecidas para realizar o backup completo do banco de dados, incluindo procedures e eventos, utilizando o mysqldump. Também é mostrado como restaurar o banco de dados a partir de um arquivo de backup.

## Instruções de Uso
### 1. Configuração Inicial
Clone o repositório:

 ```
git clone https://github.com/seu-usuario/projeto-biblioteca.git
cd projeto-biblioteca
```
  
Crie o banco de dados e as tabelas executando o script projeto_biblioteca.sql em seu cliente MySQL:

  ```
  mysql -u usuario -p < projeto_biblioteca.sql
 ```
### 2. Executando Transações
Após configurar o banco de dados, você pode executar as transações e chamar a procedure para registrar um empréstimo. Exemplos de uso estão incluídos no script.

### 3. Realizando Backup
Para realizar o backup do banco de dados, use o seguinte comando no terminal:

 ```
mysqldump -u usuario -p senha biblioteca > biblioteca_backup.sql
 ```

### 4. Restaurando Backup
Para restaurar o banco de dados a partir de um arquivo de backup, use:

 ```
mysql -u usuario -p senha biblioteca < biblioteca_backup.sql
 ```

### 5. Backup Completo com Procedures e Eventos
Para incluir procedures e eventos no backup, utilize:

 ```
mysqldump -u usuario -p senha --routines --events --databases biblioteca > backup_completo.sql
 ```
## Estrutura do Repositório
projeto_biblioteca.sql: Script SQL completo para criação do banco de dados, tabelas, procedimentos armazenados e transações.
README.md: Documentação do projeto.

## Contribuindo
Se desejar contribuir com este projeto, sinta-se à vontade para fazer um fork e enviar um pull request. Sugestões e melhorias são sempre bem-vindas!
