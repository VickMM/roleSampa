# 📍 Rolê Sampa — Banco de Dados (PostgreSQL)

Banco de dados relacional do aplicativo **Rolê Sampa**, desenvolvido como projeto acadêmico na **Fatec Zona Sul** (Análise e Desenvolvimento de Sistemas). O sistema reúne opções de lazer, cultura e pontos turísticos em São Paulo, permitindo filtrar lugares por geolocalização, faixa de preço, horários de funcionamento, recursos de acessibilidade e avaliações da comunidade.

---

## 🛠️ Tecnologias Utilizadas

* **SGBD:** PostgreSQL
* **Hospedagem / Cloud:** Neon (Serverless Postgres)
* **Linguagem:** SQL (DDL, DML e DQL)

---

## 🗂️ Estrutura do Banco de Dados

O modelo relacional foi projetado para garantir integridade referencial e evitar redundância de dados:

* **`enderecos`**: Armazena logradouro, número, bairro, CEP e coordenadas geográficas (`latitude` e `longitude`).
* **`faixas_preco`**: Classifica o custo médio dos locais (ex.: gratuito, acessível, moderado).
* **`locais`**: Tabela central com informações dos espaços (nome, telefone, site, instruções de como chegar e status de parceiro).
* **`categorias` & `locais_categorias`**: Relacionamento N:N que permite associar um mesmo local a múltiplas categorias (ex.: Parque, Cultura, Arte Urbana).
* **`horarios_funcionamento`**: Registra os dias da semana e horários de abertura/fechamento de cada espaço.
* **`acessibilidade_estrutura`**: Detalha infraestrutura inclusiva (rampa de acesso, banheiro adaptado, estacionamento, ar-condicionado, Wi-Fi gratuito e segurança).
* **`usuarios`**: Cadastro de usuários da plataforma com controle de aceite de termos.
* **`avaliacoes`**: Notas e comentários publicados pelos usuários sobre os locais visitados.

---

## 🚀 Como Executar o Script

1. Crie um banco de dados PostgreSQL (localmente ou em plataformas cloud como o Neon).
2. Abra o arquivo [`banco_role_sp.sql`](./banco_role_sp.sql) no seu editor SQL de preferência (Neon SQL Editor, pgAdmin, DBeaver ou VS Code).
3. Execute o script na ordem estruturada:
   * Criação das tabelas (`CREATE TABLE`)
   * Inserção dos dados iniciais de São Paulo (`INSERT INTO`)
   * Consultas relacionais de validação (`SELECT` com `JOIN`)

---

## 🔐 Configuração de Ambiente

Para integrar este banco a uma API/back-end, utilize uma variável de ambiente com a string de conexão do PostgreSQL (nunca exponha credenciais reais no código):

```env
DATABASE_URL="postgresql://usuario:SENHA@host.neon.tech/rolesp?sslmode=require"
