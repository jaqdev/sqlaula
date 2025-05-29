
CREATE DATABASE aula;

USE aula;
-- criar uma tabela movies com movie_id, movie tittle e genre 

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100)
);

-- criar uma tabela chamada cliente com client_id, name e email

CREATE TABLE clients (
client_id INT PRIMARY KEY,
client_name VARCHAR (255) NOT NULL,
email VARCHAR (191) UNIQUE NOT NULL
);

-- criar uma tabela com subscriptions com subscription_id
-- client_id, movie_id e subscription_date

CREATE TABLE subscriptions (
subscription_id INT PRIMARY KEY,
client_id INT,
movie_id INT,
subscription_date DATE NOT NULL,
FOREIGN KEY (client_id) REFERENCES clients(client_id),
FOREIGN KEY (client_id) REFERENCES movies(movie_id)
);

INSERT INTO movies (movie_id, title, genre) VALUES
(1, 'Inception', 'Sci-fi'),
(2, 'The Godfather', 'Crime'),
(3, 'The Dark Knight', 'Action'),
(4, 'Pulp Fiction', 'Drama'),
(5, 'Forrest Gump' , 'Drama');

INSERT INTO clients (client_id, client_name, email) VALUES
(1, 'Alice', 'alice@gmail.com'),
(2, 'Bob', 'bob@gmail.com'),
(3, 'Charlie', 'teste@gmail.com'),
(4, 'David', 'david@outlook.com'),
(5, 'Eve', 'eve@otlook.com');

INSERT INTO subscriptions (subscription_id, client_id, movie_id, subscription_date) VALUES
(1, 1, 1, '2023-01-01'),
(2, 2, 2, '2023-02-01'),
(3, 3, 3, '2023-03-01'),
(4, 4, 4, '2023-04-01'),
(5, 5, 5, '2023-05-01');

-- Listar todas as assinaturas com informações de cliente e filmes 

SELECT 
    subscriptions.subscription_id,
    clients.client_name,
    movies.title,
    subscriptions.subscription_date
FROM 
    subscriptions
INNER JOIN 
    clients ON subscriptions.client_id = clients.client_id
INNER JOIN 
    movies ON subscriptions.movie_id = movies.movie_id;
    
    -- Listar todas as assinatuas com informações de clientes e filmes
    
  SELECT 
    clients.client_name,
    subscriptions.subscription_id,
    movies.title,
    subscriptions.subscription_date
FROM
    subscriptions
INNER JOIN 
    clients ON subscriptions.client_id = clients.client_id
INNER JOIN 
    movies ON subscriptions.movie_id = movies.movie_id;
    
    -- Listar todos os clientes e suas assinaturas, incluindo clientes que não fizeram assinaturas.
    
    SELECT
    clients.client_name,
    subscriptions.subscription_id,
    movies.movie_title,
    subscriptions.subscription_date
    FROM
    clients
    LEFT JOIN
    subscriptions ON clients.client_id = subscriptions.client_id
    LEFT JOIN
    movies ON subscriptions.movie_id = movies.movie_id;
    
    -- Listar todos os filmes e as assinaturas feitas, incluindo filmes que não foram assinados.
    
   SELECT
   movies.title,
   subscriptions.subscription_id,
   clients.client_name,
   subscriptions.subscription_date
   FROM 
   movies
   RIGHT JOIN
   subscriptions ON movies.movie_id = subscriptions.movie_id
   RIGHT JOIN 
   clients ON subscriptions.client_id = clients.client_id;
    
    -- Listar todos os clientes e filmes, incluindo aqueles que não têm assinaturas.
    
    SELECT 
    clients.client_name,
     movies.title,
    subscriptions.subscription_id,
    subscriptions.subscription_date
    FROM
    clients
    FULL OUTER JOIN
    subscriptions ON clients.client_id = subscriptions.client_id
    FULL OUTER JOIN 
    movies ON subscriptions.movie_id = movies.movie_id;
    
    -- Listar todas as combinações possíveis de clientes e filmes.
    
SELECT 
clients.client_name,
movies.title
FROM 
clients
CROSS JOIN
movies;


-- Criação tabela eventos 


CREATE TABLE events (
event_id INT PRIMARY KEY,
event_name VARCHAR (50),
event_date DATE

);


CREATE TABLE participants (
participant_id INT PRIMARY KEY,
PARTICIPANT_NAME VARCHAR(50),
email VARCHAR (50)
);

CREATE TABLE registrations (
registration_id INT PRIMARY KEY,
participant_id INT,
event_id INT,
registration_date DATE,
FOREIGN KEY (participant_id) REFERENCES participants (participant_id),
FOREIGN KEY (event_id) REFERENCES events(event_id)
);

-- Inserção de dados

INSERT INTO events (event_id, event_name, event_date) VALUES
(1, 'Tech Conference', '2023-11-01'),
(2, 'Music Festival', '2023-12-15'),
(3, 'Art exhibition', '2023-10-20'),
(4, 'Food fair', '2023-11-10');

INSERT INTO participants (participant_id, participant_name, email) VALUES
(1, 'Emma', 'emma@example.com'),
(2, 'Liam', 'liam@example.com'),
(3, 'Olivia', 'olivia@example.com'),
(4,'Noah', 'noah@example.com');

INSERT INTO registrations (registration_id, participant_id, event_id, registration_date) VALUES
(1, 1, 1, '2023-10-01'),
(2, 2, 2, '2023-10-05'),
(3, 3, 3, '2023-09-20'),
(4, 4, 4, '2023-10-10'),
(5, 1, 2, '2023-10-15');

-- INNER JOIN Objetivo Listar todas as inscrições com informações de participantes e eventos.

SELECT 
registrations.registration_id,
participants.participant_name,
events.event_name,
registrations.registration_date
FROM
registrations
INNER JOIN
participants ON registrations.participant_id = participants.participant_id
INNER JOIN 
events on registrations.event_id = events.event_id;

-- LEFT JOIN Objetivo Listar todos os participantes e suas inscrições, incluindo participantes que não fizeram inscrições.

SELECT 
participants.participant_name,
registrations.registration_id,
events.event_name,
registrations.registration_date

FROM 
participants

LEFT JOIN 
registrations ON participants.participant_id = registrations.participant_id
LEFT JOIN
events ON registrations.event_id = events.event_id;

-- RIGHT JOIN Objetivo: Listar todos os eventos e as inscrições feitas, incluindo eventos que não têm inscrições.

SELECT
events.event_name,
registrations.registration_id,
participants.participant_name,
registrations.registration_date
FROM
events
RIGHT JOIN
registrations ON events.event_id = registrations.event_id
RIGHT JOIN
participants ON registrations.participant_id = participants.participant_id;

-- CROSS JOIN Objetivo Listar todas as combinações possíveis de participantes e eventos.

SELECT 
participants.participant_name,
events.event_name

FROM
participants

CROSS JOIN
events;

-- Criação função para verificar maioridade 



CREATE TABLE participantes (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR (100),
data_nascimento DATE
);

INSERT INTO participantes (nome, data_nascimento) VALUES
('Alice Ferreira', '2007-04-15'),
('Bruno Lima', '1998-08-21'),
('Carla Souza','2010-11-30'),
('Daniel Monteiro', '2003-01-09');


DELIMITER $$

CREATE FUNCTION verifica_marioridade(data_nascm DATE)
RETURNS VARCHAR (20)
DETERMINISTIC 
BEGIN 
DECLARE idade INT;
SET idade = TIMESTAMPDIFF (YEAR, data_nasc, DATE(NOW()));

IF idade >=18 THEN

RETURN 'maior de idade';

ELSE 

RETURN 'menor de idade';

END IF;

END $$



-- Criação triggers

-- tabela principal de usuarios
CREATE TABLE usuarios (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR (100),
email VARCHAR (100),
cargo VARCHAR (50)
);


-- tabela de auditoria
CREATE TABLE auditoria_usuarios (
id INT AUTO_INCREMENT PRIMARY KEY,
id_usuario INT,
campo_alterado VARCHAR(50),
valor_antigo VARCHAR(100),
valor_novo VARCHAR(100),
data_alteracao DATETIME 
);

-- Iserção de dados

INSERT INTO usuarios (nome, email, cargo) VALUES
('João Pereira', 'joao.pereira@email.com','analista'),
('Maria Oliveira', 'maria.oliveira@email.com','gerente'),
('Carlos Mendes', 'carlos.mendes@email.com','tecnico');

DELIMITER$$

CREATE TRIGGER tgr_auditoria_usuarios
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN

-- verifica alteração no nome 
IF OLD.nome <> NEW.nome THEN 
INSERT INTO auditoria_usuarios (id_usuario, campo_alterado, valor_antigo, valor_novo, data_alteracao)
VALUES (OLD.id, 'nome', OLD.nome, NEW.nome, NOW());

END IF;

-- verifica alteração no email
IF OLD.email <> NEW.email THEN
INSERT INTO auditoria_usuarios (id_usuario, campo_alterado, valor_antigo, valor_novo, data_alteracao)
VALUES (OLD.id, 'email', OLD.email, NEW.email, NOW());

END IF; 

-- vefirica alteração no cargo
IF OLD.cargo <> NEW.cargo THEN
INSERT INTO auditoria_usuarios (id_usuario, campo_alterado, valor_antigo, valor_novo, data_alteracao)
VALUES (OLD.id, 'cargo', OLD.cargo, NEW.cargo, NOW());

END IF;

END$$

DELIMITER ;

-- tabela cliente
CREATE TABLE clientes (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR (100),
email VARCHAR(100)
);

-- tabela pedidos
CREATE TABLE pedidos (
id INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT,
valor_total DECIMAL (10,2),
data_pedido DATE,
FOREIGN KEY (id_cliente) REFERENCES clientes (id)
);

-- Inserção de dados

INSERT INTO clientes (nome, email) VALUES
('Alice Costa', 'alice@email.com'),
('Bruno Silva', 'bruno@email.com'),
('Carla Mendes' , 'carla@email.com');

INSERT INTO pedidos (id_cliente, valor_total, data_pedido) VALUES
(1, 350.00, '2025-01-10'),
(1,1200.00, '2025-02-15'),
(2, 499.90, '2025-03-05'),
(3,150.00, '2025-03-07'),
(2, 399.00, '2025-04-01');



CREATE VIEW relatorio_clientes AS
SELECT 
    c.nome,
    COUNT(p.id) AS total_pedidos,
    SUM(p.valor_total) AS total_gasto
FROM 
    clientes c
JOIN 
    pedidos p ON c.id = p.id_cliente
GROUP BY 
    c.id, c.nome;
    
    SELECT * FROM relatorio_clientes;
