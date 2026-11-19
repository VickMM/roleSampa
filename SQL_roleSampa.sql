CREATE TABLE usuarios (
  id_usuario SERIAL PRIMARY KEY,
  nome_usuario VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  senha_hash VARCHAR(100) UNIQUE NOT NULL, 
  data_nascimento DATE NOT NULL,
  tipo_usuario VARCHAR(20) NOT NULL, --comum, moderador ou admin
  aceite_termos_em TIMESTAMP NOT NULL,
  criado_em TIMESTAMP NOT NULL
);

CREATE TABLE enderecos (
  id_endereco SERIAL PRIMARY KEY,
  numero VARCHAR (10) NOT NULL,
  logradouro VARCHAR (100) NOT NULL,
  bairro VARCHAR (30) NOT NULL,
  cep VARCHAR (9) NOT NULL,
  cidade VARCHAR (30) NOT NULL,
  estado VARCHAR (30) NOT NULL,
  latitude DECIMAL(9,6) NULL,
  longitude DECIMAL(9,6) NULL
);

CREATE TABLE faixas_preco (
  id_faixa_preco SERIAL PRIMARY KEY,
  descricao VARCHAR(50) NOT NULL,
  valor_estimado VARCHAR (10) NOT NULL,
  data_referencia DATE NULL
);

CREATE TABLE categorias (
  id_categoria SERIAL PRIMARY KEY,
  nome VARCHAR(50) UNIQUE NOT NULL 
);


CREATE TABLE locais (
    id_local SERIAL PRIMARY KEY,
    id_endereco INT NOT NULL,
    id_faixa_preco INT NOT NULL,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20) NULL,
    site VARCHAR(255) NULL,
    como_chegar TEXT NULL,
    e_parceiro BOOLEAN NOT NULL,
    criado_em TIMESTAMP NOT NULL,
    atualizado_em TIMESTAMP NOT NULL,
    FOREIGN KEY (id_endereco) REFERENCES enderecos(id_endereco),
    FOREIGN KEY (id_faixa_preco) REFERENCES faixas_preco(id_faixa_preco)
);


CREATE TABLE locais_categorias (
    id_local INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_local, id_categoria),
    FOREIGN KEY (id_local) REFERENCES locais(id_local),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);


CREATE TABLE horarios_funcionamento (
    id_horario SERIAL PRIMARY KEY,
    id_local INT NOT NULL,
    dia_semana VARCHAR(20) NOT NULL,
    horario_abertura TIME NOT NULL,
    horario_fechamento TIME NOT NULL,
    atualizado_em TIMESTAMP NOT NULL,
    FOREIGN KEY (id_local) REFERENCES locais(id_local)
);


CREATE TABLE acessibilidade_estrutura (
    id_acessibilidade SERIAL PRIMARY KEY,
    id_local INT UNIQUE NOT NULL,
    rampa_acesso BOOLEAN NOT NULL,
    banheiro_adaptado BOOLEAN NOT NULL,
    estacionamento BOOLEAN NOT NULL,
    ar_condicionado BOOLEAN NOT NULL,
    wifi_gratis BOOLEAN NOT NULL,
    seguranca BOOLEAN NOT NULL,
    FOREIGN KEY (id_local) REFERENCES locais(id_local)
);


CREATE TABLE eventos (
    id_evento SERIAL PRIMARY KEY,
    id_local INT NOT NULL,
    id_categoria INT NOT NULL,
    nome_evento VARCHAR(150) NOT NULL,
    descricao TEXT NULL,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP NOT NULL,
    preco_ingresso DECIMAL(10,2) NULL,
    atualizado_em TIMESTAMP NOT NULL,
    FOREIGN KEY (id_local) REFERENCES locais(id_local),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);


CREATE TABLE avaliacoes (
    id_avaliacao SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_local INT NULL,
    id_evento INT NULL,
    nota INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT NULL,
    data_publicacao TIMESTAMP NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_local) REFERENCES locais(id_local),
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento)
);


CREATE TABLE denuncias_avaliacao (
    id_denuncia SERIAL PRIMARY KEY,
    id_avaliacao INT NOT NULL,
    id_usuario_denunciante INT NOT NULL,
    id_moderador INT NULL,
    motivo VARCHAR(255) NOT NULL,
    status_moderacao VARCHAR(50) NOT NULL,
    data_denuncia TIMESTAMP NOT NULL,
    data_moderacao TIMESTAMP NULL,
    FOREIGN KEY (id_avaliacao) REFERENCES avaliacoes(id_avaliacao),
    FOREIGN KEY (id_usuario_denunciante) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_moderador) REFERENCES usuarios(id_usuario)
);


CREATE TABLE conteudos_patrocinados (
    id_patrocinio SERIAL PRIMARY KEY,
    id_local INT NULL,
    id_evento INT NULL,
    titulo VARCHAR(150) NOT NULL,
    descricao_anuncio TEXT NOT NULL,
    link_promocional VARCHAR(255) NULL,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP NOT NULL,
    FOREIGN KEY (id_local) REFERENCES locais(id_local),
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento)
);






-- 1. Faixas de preço
INSERT INTO faixas_preco (descricao, valor_estimado, data_referencia) VALUES
('Barato', '$', '2026-11-01'),
('Médio', '$$', '2026-11-01');

-- 2. Categorias
INSERT INTO categorias (nome) VALUES
('Parque'),
('Bar'),
('Cultural');

-- 3. Endereços em SP (com latitude e longitude)
INSERT INTO enderecos (logradouro, numero, bairro, cidade, cep, latitude, longitude) VALUES
('Av. Pedro Álvares Cabral', 's/n', 'Vila Mariana', 'São Paulo', '04094-050', -23.587416, -46.657634),
('Av. Paulista', '1578', 'Bela Vista', 'São Paulo', '01310-200', -23.561414, -46.655881),
('Rua Harmonia', '452', 'Vila Madalena', 'São Paulo', '05435-000', -23.554012, -46.686911);

INSERT INTO enderecos (numero, logradouro, bairro, cep, cidade, estado, latitude, longitude) VALUES
('s/n', 'Av. Pedro Álvares Cabral', 'Vila Mariana', '04094-050', 'São Paulo', 'SP', -23.587416, -46.657634),
('1578', 'Av. Paulista', 'Bela Vista', '01310-200', 'São Paulo', 'SP', -23.561414, -46.655881),
('452', 'Rua Harmonia', 'Vila Madalena', '05435-000', 'São Paulo', 'SP', -23.554012, -46.686911);

-- 5. Relação Local x Categoria
INSERT INTO locais_categorias (id_local, id_categoria) VALUES
(1, 1),
(2, 3),
(3, 3),
(3, 2);

-- 6. Horários de funcionamento
INSERT INTO horarios_funcionamento (id_local, dia_semana, horario_abertura, horario_fechamento, atualizado_em) VALUES
(1, 'Segunda a Domingo', '05:00:00', '23:00:00', NOW()),
(2, 'Terça a Domingo', '10:00:00', '18:00:00', NOW()),
(3, 'Segunda a Domingo', '00:00:00', '23:59:00', NOW());

-- 7. Acessibilidade e estrutura
INSERT INTO acessibilidade_estrutura (id_local, rampa_acesso, banheiro_adaptado, estacionamento, ar_condicionado, wifi_gratis, seguranca) VALUES
(1, true, true, true, false, true, true),
(2, true, true, false, true, true, true),
(3, false, false, false, false, false, true);

-- 8. Usuário de teste
INSERT INTO usuarios (nome, email, senha_hash, data_nascimento, tipo_usuario, aceite_termos_em, criado_em) VALUES
('Vitória Teste', 'vitoria.teste@exemplo.com', 'hash_exemplo_123', '2000-05-10', 'comum', NOW(), NOW());

-- 9. Avaliação de teste
INSERT INTO avaliacoes (id_usuario, id_local, id_evento, nota, comentario, data_publicacao) VALUES
(1, 1, NULL, 5, 'Ótimo lugar para passear e relaxar.', NOW());





INSERT INTO locais_categorias (id_local, id_categoria) VALUES
(13, 1),
(14, 3),
(15, 3),
(15, 2);

INSERT INTO horarios_funcionamento (id_local, dia_semana, horario_abertura, horario_fechamento, atualizado_em) VALUES
(13, 'Segunda a Domingo', '05:00:00', '23:00:00', NOW()),
(14, 'Terça a Domingo', '10:00:00', '18:00:00', NOW()),
(15, 'Segunda a Domingo', '00:00:00', '23:59:00', NOW());

INSERT INTO acessibilidade_estrutura (id_local, rampa_acesso, banheiro_adaptado, estacionamento, ar_condicionado, wifi_gratis, seguranca) VALUES
(13, true, true, true, false, true, true),
(14, true, true, false, true, true, true),
(15, false, false, false, false, false, true);

INSERT INTO usuarios (nome, email, senha_hash, data_nascimento, tipo_usuario, aceite_termos_em, criado_em) VALUES
('Vitória Teste', 'vitoria.teste@exemplo.com', 'hash_exemplo_123', '2000-05-10', 'comum', NOW(), NOW());

INSERT INTO avaliacoes (id_usuario, id_local, id_evento, nota, comentario, data_publicacao) VALUES
(1, 13, NULL, 5, 'Ótimo lugar para passear e relaxar.', NOW());




SELECT
  l.id_local,
  l.nome AS local,
  e.bairro,
  e.latitude,
  e.longitude,
  fp.descricao AS faixa_preco,
  a.nota,
  a.comentario
FROM locais l
JOIN enderecos e ON l.id_endereco = e.id_endereco
JOIN faixas_preco fp ON l.id_faixa_preco = fp.id_faixa_preco
LEFT JOIN avaliacoes a ON a.id_local = l.id_local;


SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


SELECT id_endereco, logradouro, numero, bairro, latitude, longitude FROM enderecos;
SELECT id_local, nome, id_endereco, id_faixa_preco FROM locais;
SELECT id_categoria, nome FROM categorias;

SELECT
  l.id_local,
  l.nome AS local,
  e.bairro,
  e.latitude,
  e.longitude,
  fp.descricao AS faixa_preco,
  a.nota,
  a.comentario
FROM locais l
JOIN enderecos e ON l.id_endereco = e.id_endereco
JOIN faixas_preco fp ON l.id_faixa_preco = fp.id_faixa_preco
LEFT JOIN avaliacoes a ON a.id_local = l.id_local;

SELECT * FROM horarios_funcionamento;
SELECT * FROM acessibilidade_estrutura;
SELECT id_usuario, nome, email, tipo_usuario FROM usuarios;









