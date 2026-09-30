# Relatório da Prova Prática — DevOps

**Aluno:** Eloísa Brandão
**RA:** 2325096
**Disciplina:** DevOps — 2026.2
**Professor:** Alexandre Tavares Jr.

## 1. Jornada pelas Aulas 01 a 07

**Ferramenta principal de apoio:** ChatGPT.

A realização da prova foi baseada nos conhecimentos desenvolvidos progressivamente nas Aulas 01 a 07 da disciplina.
Na **Aula 01**, foram utilizados Git, branches, Conventional Commits e os primeiros conceitos de Docker para organizar o projeto.
Na **Aula 02**, os conhecimentos de Docker Compose e PostgreSQL foram utilizados para montar o ambiente local da API.
Também foram aplicados conceitos de volume, rede, healthcheck, variáveis de ambiente e dependência entre containers.
Na **Aula 03**, os conhecimentos de Terraform e segurança foram utilizados como base para a infraestrutura na AWS.
Nas **Aulas 04, 05 e 06**, foram aplicados os conceitos de VPC, subnets públicas e privadas, Security Groups, EC2, RDS, módulos e Remote State.
A infraestrutura foi organizada em módulos para VPC, Security Group, EC2 e RDS, utilizando entradas e saídas entre eles.
Na **Aula 07**, os conceitos de especificação e divisão do problema em requisitos e tarefas ajudaram na organização do desenvolvimento da aplicação.
A implementação foi feita de forma incremental, começando pela aplicação e ambiente local, passando pelo Docker e chegando ao Terraform e AWS.
Esse processo ajudou a perceber que cada aula serviu como uma etapa para construir a solução completa da prova, em vez de desenvolver tudo de uma única vez.

## 2. Uso da Inteligência Artificial como Copiloto

**Ferramentas utilizadas:** ChatGPT e **Codex – OpenAI's coding agent**, integrado ao VS Code.

O ChatGPT foi utilizado durante o desenvolvimento para orientar a implementação, explicar erros, revisar decisões e ajudar na validação das etapas do projeto.
Entre os principais pedidos estavam a criação e correção da API, organização do Docker Compose, implementação do Terraform e análise dos problemas encontrados na AWS.
Também utilizei o ChatGPT para interpretar mensagens de erro e definir formas de testar a comunicação entre a EC2 e o RDS.
O Codex foi utilizado posteriormente dentro do VS Code como apoio direto ao código e à revisão do projeto.
A IA foi útil principalmente para acelerar a criação da estrutura inicial e indicar possíveis problemas antes da validação manual.
Um exemplo foi a identificação de que o contrato inicial da API não estava de acordo com o solicitado na prova, sendo necessário corrigir os campos para `id`, `cliente`, `data` e `status`.
Também houve situações em que as sugestões precisaram ser corrigidas ou testadas novamente, principalmente nos comandos PowerShell, SSM e configuração da infraestrutura.
Um exemplo foi a dificuldade para montar os comandos do SSM devido ao escaping de aspas e ao uso de JSON pelo PowerShell.
Nesse caso, a solução final foi obtida por meio de testes e correções, incluindo a criação de um arquivo JSON sem BOM para executar o comando corretamente.
A IA economizou tempo, mas não substituiu a validação: os comandos, arquivos e resultados precisaram ser conferidos manualmente para evitar aceitar uma solução incorreta.

## 3. Arquitetura, Segurança e Restrições do AWS Academy

**Ferramentas utilizadas:** Terraform, AWS Academy, ChatGPT e Codex no VS Code.

A arquitetura foi criada na região `us-east-1`, utilizando os recursos disponibilizados pelo AWS Academy Learner Lab.
Foi criada uma VPC com CIDR `10.0.0.0/16`, contendo duas subnets públicas e duas subnets privadas distribuídas em duas Availability Zones.
A EC2 foi colocada em uma subnet pública para permitir o acesso à API pela Internet.
O RDS PostgreSQL foi colocado em subnets privadas e configurado com `publicly_accessible = false`.
O armazenamento do RDS também foi configurado com criptografia e o acesso à porta 5432 foi restringido ao Security Group da EC2.
A EC2 utilizou uma instância `t2.micro`, enquanto o RDS utilizou uma instância `db.t3.micro`, adequadas ao ambiente do laboratório.
Como o AWS Academy possui restrições de IAM, não foram criados usuários, grupos ou roles próprios; foi utilizada a infraestrutura existente do laboratório, incluindo `LabRole`/`LabInstanceProfile`.
As credenciais utilizadas no ambiente eram temporárias, fornecidas pelo próprio AWS Academy, e a região utilizada foi mantida em `us-east-1`.
Durante a configuração do Remote State, houve uma limitação de permissão relacionada ao `s3:GetBucketObjectLockConfiguration`, mostrando uma das restrições práticas do ambiente Academy.
Na validação da rede, o endpoint privado do RDS foi resolvido a partir da EC2 e o teste executado pelo SSM retornou `RDS_PORT_OPEN`, confirmando a comunicação EC2 → RDS na porta 5432.
Ao final, o `terraform destroy` foi executado e confirmou a remoção de 14 recursos da infraestrutura principal, incluindo EC2, RDS e VPC.

## 4. Validação, Responsabilidade e Uso da IA

**Ferramentas utilizadas:** ChatGPT, Codex, Git, Docker, Terraform e AWS.

Antes de aplicar qualquer infraestrutura gerada ou alterada com auxílio de IA, a primeira preocupação foi verificar se os arquivos realmente atendiam aos requisitos da prova.
A validação começou pelo código da API, conferindo as rotas, os campos obrigatórios, os códigos de resposta e a persistência no PostgreSQL.
No ambiente local, o endpoint `/health` respondeu com `{"status":"ok"}` e HTTP 200.
Também foi validado o CRUD de reservas, incluindo criação, consulta, consulta por ID, atualização, exclusão, erro 404 para ID inexistente e erro 400 para campos obrigatórios ausentes.
No Docker Compose, foram verificados a API, o PostgreSQL, a rede, o volume e o healthcheck do banco.
No Terraform, foram utilizadas validações como `terraform init -backend=false`, `terraform validate` e `terraform fmt -check -recursive`, além da revisão dos módulos e das regras de segurança.
Na AWS, foram conferidos a comunicação entre EC2 e RDS, o Security Group, as subnets e o acesso privado ao banco.
Durante o processo apareceram erros que mostraram a importância de não aceitar automaticamente uma resposta da IA, principalmente em comandos PowerShell, SSM e configurações da AWS.
O fluxo utilizado foi, portanto, Git para versionamento, Docker para reproduzir o ambiente, T
