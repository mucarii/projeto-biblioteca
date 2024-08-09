-- Criação do Banco de Dados e das Tabelas

CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

-- Tabela de livros
CREATE TABLE IF NOT EXISTS livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    ano_publicacao INT,
    genero VARCHAR(100)
);

-- Tabela de estoque
CREATE TABLE IF NOT EXISTS estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (livro_id) REFERENCES livros(id)
);

-- Tabela de empréstimos
CREATE TABLE IF NOT EXISTS emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT,
    leitor VARCHAR(255) NOT NULL,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (livro_id) REFERENCES livros(id)
);

-- Inserção de dados iniciais
INSERT INTO livros (titulo, autor, ano_publicacao, genero) VALUES 
('Dom Casmurro', 'Machado de Assis', 1899, 'Romance'),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 1954, 'Fantasia'),
('1984', 'George Orwell', 1949, 'Distopia')
ON DUPLICATE KEY UPDATE titulo=VALUES(titulo);

INSERT INTO estoque (livro_id, quantidade) VALUES
(1, 10),
(2, 5),
(3, 8)
ON DUPLICATE KEY UPDATE quantidade=VALUES(quantidade);

-- Transações

-- Desabilitar autocommit
SET autocommit = 0;

-- Iniciar transação
START TRANSACTION;

-- Inserir novo empréstimo e atualizar o estoque
INSERT INTO emprestimos (livro_id, leitor, data_emprestimo, data_devolucao)
VALUES (1, 'João Silva', CURDATE(), '2024-08-19');

UPDATE estoque SET quantidade = quantidade - 1 WHERE livro_id = 1;

-- Confirmar transação
COMMIT;

-- Transação com Procedure

DELIMITER //

CREATE PROCEDURE RegistrarEmprestimo(
    IN p_livro_id INT, 
    IN p_leitor VARCHAR(255), 
    IN p_data_devolucao DATE)
BEGIN
    DECLARE quantidade_atual INT;

    -- Manipulador de erros
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Início da transação
    START TRANSACTION;

    -- Verifica a quantidade disponível
    SELECT quantidade INTO quantidade_atual 
    FROM estoque WHERE livro_id = p_livro_id FOR UPDATE;

    -- Verifica se há quantidade suficiente
    IF quantidade_atual > 0 THEN
        -- Registra o empréstimo
        INSERT INTO emprestimos (livro_id, leitor, data_emprestimo, data_devolucao)
        VALUES (p_livro_id, p_leitor, CURDATE(), p_data_devolucao);

        -- Atualiza o estoque
        UPDATE estoque SET quantidade = quantidade - 1 WHERE livro_id = p_livro_id;

        -- Confirma a transação
        COMMIT;
    ELSE
        -- Se não há quantidade suficiente, realiza o rollback
        ROLLBACK;
    END IF;
END //

DELIMITER ;

-- Exemplo de chamada da procedure
CALL RegistrarEmprestimo(1, 'Maria Souza', '2024-08-15');

-- Backup e Recovery (instruções para execução no terminal)

-- Para realizar o backup:
-- mysqldump -u usuario -p senha biblioteca > biblioteca_backup.sql

-- Para restaurar o backup:
-- mysql -u usuario -p senha biblioteca < biblioteca_backup.sql

-- Para incluir procedures e eventos no backup:
-- mysqldump -u usuario -p senha --routines --events --databases biblioteca > backup_completo.sql

