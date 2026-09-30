# API de Reservas — TechNova

**Aluno:** Eloísa Brandão
**RA:** 2325096
**Disciplina:** DevOps — 2026.2
**Professor:** Alexandre Tavares Jr.

## Descrição

Projeto desenvolvido para a **Prova do Primeiro Bimestre de DevOps**, reunindo conhecimentos trabalhados nas Aulas 01 a 07.

A solução consiste em uma API REST de reservas desenvolvida com **Node.js e Express**, utilizando **PostgreSQL** para persistência dos dados.

O desenvolvimento seguiu a evolução:

**Git → API → Docker → Docker Compose → Terraform → AWS → Modules → Remote State → IA como copiloto**

A infraestrutura foi criada no **AWS Academy Learner Lab** e, após as validações, os recursos principais foram destruídos para evitar consumo desnecessário dos créditos do laboratório.

## Tecnologias utilizadas

* Node.js
* Express
* PostgreSQL
* Docker
* Docker Compose
* Terraform
* AWS VPC
* AWS EC2
* AWS RDS
* Amazon S3
* Amazon DynamoDB
* Git
* GitHub
* ChatGPT
* Codex — OpenAI's coding agent

## API

A aplicação possui um CRUD para o recurso `reservas`.

### Campos

| Campo     | Descrição                |
| --------- | ------------------------ |
| `id`      | Identificador da reserva |
| `cliente` | Nome do cliente          |
| `data`    | Data da reserva          |
| `status`  | Situação da reserva      |

### Endpoints

| Método | Rota            | Descrição                       |
| ------ | --------------- | ------------------------------- |
| GET    | `/health`       | Verifica o funcionamento da API |
| POST   | `/reservas`     | Cria uma reserva                |
| GET    | `/reservas`     | Lista as reservas               |
| GET    | `/reservas/:id` | Busca uma reserva pelo ID       |
| PUT    | `/reservas/:id` | Atualiza uma reserva            |
| DELETE | `/reservas/:id` | Remove uma reserva              |

### Exemplo de criação

```json
{
  "cliente": "Maria Silva",
  "data": "2026-10-15",
  "status": "confirmada"
}
```

Os dados são persistidos no **PostgreSQL**, não sendo mantidos somente em memória.

## Execução local

Com Docker e Docker Compose instalados, execute na raiz do projeto:

```bash
docker compose up --build
```

A API ficará disponível em:

```text
http://localhost:3000
```

Health check:

```text
http://localhost:3000/health
```

Para encerrar os containers:

```bash
docker compose down
```

## Docker

A aplicação possui um `Dockerfile` para criação da imagem da API.

A configuração utiliza:

* build multi-stage;
* imagem baseada em Node.js;
* execução da aplicação com usuário não-root;
* `.dockerignore` para evitar o envio de arquivos desnecessários para o contexto de build.

## Docker Compose

O ambiente local é composto por:

* container da API;
* container PostgreSQL;
* rede Docker personalizada;
* volume nomeado para persistência do PostgreSQL;
* healthcheck do banco;
* dependência da API em relação à disponibilidade do PostgreSQL;
* variáveis de ambiente para configuração da aplicação.

O arquivo `.env` é ignorado pelo Git e o projeto disponibiliza um `.env.example` como modelo de configuração.

## Infraestrutura AWS

A infraestrutura foi definida com **Terraform** e executada no **AWS Academy Learner Lab**, utilizando a região `us-east-1`.

A arquitetura possui:

* VPC `10.0.0.0/16`;
* duas subnets públicas;
* duas subnets privadas;
* distribuição em duas Availability Zones;
* EC2 `t2.micro` em subnet pública;
* RDS PostgreSQL `db.t3.micro` em subnets privadas;
* Security Groups para controle do acesso;
* comunicação EC2 → RDS pela porta `5432`;
* RDS configurado como não publicamente acessível;
* armazenamento do RDS com criptografia;
* Remote State utilizando S3 e DynamoDB.

### Arquitetura simplificada

```text
                    Internet
                       |
                       v
              +----------------+
              |  EC2 t2.micro  |
              | Subnet Pública |
              +-------+--------+
                      |
                   TCP 5432
                      |
                      v
              +----------------+
              | RDS PostgreSQL |
              | Subnet Privada |
              |   db.t3.micro  |
              +----------------+
```

O acesso ao banco não é realizado diretamente pela Internet. A comunicação com o RDS é controlada pelo Security Group, permitindo acesso a partir da EC2.

## Módulos Terraform

A infraestrutura foi organizada em módulos:

```text
infra/
├── modules/
│   ├── vpc/
│   ├── security-group/
│   ├── ec2/
│   └── rds/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars.example
```

Os módulos utilizam variáveis e outputs para permitir a composição dos recursos e o relacionamento entre eles.

## Remote State

O projeto utiliza Remote State do Terraform com:

* Amazon S3 para armazenamento do state;
* versionamento do bucket;
* criptografia;
* DynamoDB para controle de lock do state.

Essa configuração evita manter o state somente de forma local e permite maior controle sobre o estado da infraestrutura.

## Segurança

O RDS foi configurado com:

```text
publicly_accessible = false
```

O banco utiliza a porta `5432` e o acesso é controlado pelo Security Group da infraestrutura.

A EC2 utiliza a porta `3000` para disponibilizar a API e a porta `22` para acesso administrativo conforme a configuração utilizada no laboratório.

Por utilizar o AWS Academy Learner Lab, foram utilizadas as permissões e recursos disponibilizados pelo ambiente, sem criação de usuários, grupos ou roles IAM próprias.

## Git e versionamento

O projeto foi desenvolvido utilizando Git e GitHub.

Foram utilizados:

* branches para organização do desenvolvimento;
* Conventional Commits;
* commits separados por funcionalidade;
* branch específica para a infraestrutura Terraform;
* merge da branch de infraestrutura para a branch principal.

Exemplos de commits utilizados:

```text
chore: inicializa estrutura do projeto
feat: implementa api e ambiente docker
feat: adiciona infraestrutura de rede
feat: adiciona security groups
feat: adiciona ec2 e rds
feat: configura infraestrutura terraform
feat: configura remote state
fix: corrige contrato da API de reservas
```

## Validações

### API local

Foram realizadas validações do funcionamento da aplicação com PostgreSQL:

* `GET /health`;
* criação de reserva com `POST /reservas`;
* listagem com `GET /reservas`;
* busca por ID com `GET /reservas/:id`;
* atualização com `PUT /reservas/:id`;
* exclusão com `DELETE /reservas/:id`;
* retorno `404` para reserva inexistente;
* retorno `400` para dados obrigatórios ausentes.

O health check retornou:

```json
{
  "status": "ok"
}
```

Também foi confirmada a persistência de uma reserva no PostgreSQL durante os testes locais.

### Infraestrutura AWS

A comunicação entre EC2 e RDS foi validada utilizando AWS Systems Manager.

O teste de conectividade para a porta `5432` retornou:

```text
RDS_PORT_OPEN
```

Esse resultado confirmou a comunicação de rede entre a EC2 e o RDS privado.

Após as validações, o `terraform destroy` removeu os **14 recursos da infraestrutura principal**, incluindo EC2, RDS e VPC.

## Inteligência Artificial como copiloto

Durante o desenvolvimento foram utilizadas duas ferramentas de IA:

* **ChatGPT**, utilizado para orientação, análise, implementação, resolução de problemas e validação;
* **Codex — OpenAI's coding agent**, utilizado integrado ao VS Code como apoio ao desenvolvimento e revisão do código.

As sugestões das ferramentas não foram aceitas automaticamente. Os códigos, comandos e configurações foram analisados e testados durante o desenvolvimento.

O processo de utilização da IA, as correções realizadas e os principais aprendizados estão descritos no:

```text
relatorio.md
```

## Evidências

As evidências relacionadas às validações da prova podem ser organizadas no diretório:

```text
evidencias/
```

## Estrutura do projeto

```text
prova-primeiro-bimestre-devops/
├── app/
│   ├── Dockerfile
│   ├── package.json
│   └── src/
│       ├── db.js
│       ├── server.js
│       └── routes/
│           └── reservas.js
├── database/
│   └── init/
│       └── 01-create-table.sql
├── infra/
│   ├── modules/
│   │   ├── vpc/
│   │   ├── security-group/
│   │   ├── ec2/
│   │   └── rds/
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── evidencias/
├── .dockerignore
├── .env.example
├── .gitignore
├── docker-compose.yml
├── README.md
└── relatorio.md
```

## Relatório

O relatório da prova está disponível em:

```text
relatorio.md
```

O documento apresenta:

1. a jornada pelas Aulas 01 a 07;
2. o uso do ChatGPT e do Codex como ferramentas de IA;
3. a arquitetura e as decisões de segurança na AWS;
4. as validações realizadas e a responsabilidade na utilização de código gerado por IA.
