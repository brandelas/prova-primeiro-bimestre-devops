# Evidências — Prompts utilizados na prova

Este documento reúne os registros de prompts e mensagens relacionados à realização da Prova do Primeiro Bimestre de DevOps.

Os registros foram organizados de acordo com o histórico disponível. Quando o texto original da mensagem enviada está disponível, ele é preservado. Quando o histórico recuperável contém apenas o conteúdo ou o resultado da interação, isso é indicado explicitamente, sem reconstrução ou criação de um prompt que não esteja registrado.

---

## 1. Validação do Terraform

### Prompt/comando enviado

```text
terraform -chdir=infra fmt -recursive
terraform -chdir=infra validate
```

### Objetivo/contexto

Validar a formatação e a configuração do Terraform da infraestrutura da prova.

---

## 2. Correção de erros do Terraform

### Mensagem registrada

```text
terraform fmt falhou com “Missing newline after block definition” e terraform init -backend=false com “Duplicate module call”; depois terraform validate reportou ambos.
```

### Objetivo/contexto

Analisar os erros encontrados durante a validação da infraestrutura e corrigir a configuração.

### Observação

Este registro preserva o conteúdo do problema, mas não há segurança de que corresponda ao texto integral da mensagem original enviada naquele momento. Por isso, não é apresentado como uma transcrição literal completa.

---

## 3. Conferência da API em produção

### Prompt/comando enviado

```text
Invoke-RestMethod http://54.162.90.104:3000/reservas
```

### Resultado registrado

```text
{"error":"Erro interno ao buscar reservas"}
```

### Objetivo/contexto

Verificar o endpoint `/reservas` da API publicada na EC2 e investigar o erro interno.

---

## 4. Verificação do status da EC2

### Prompt/comando enviado

```text
aws ec2 describe-instance-status ... --instance-ids i-08b37b3894aef9881 ... --query "InstanceStatuses[0].{Instance:InstanceState.Name,InstanceStatus:InstanceStatus.Status,SystemStatus:SystemStatus.Status}"
```

### Resultado registrado

A instância estava `running`, mas `InstanceStatus` e `SystemStatus` estavam `initializing`.

### Objetivo/contexto

Verificar se a EC2 estava realmente pronta para receber requisições.

---

## 5. Verificação do SSM

### Prompt/comando enviado

```text
aws ssm describe-instance-information ... --query "InstanceInformationList[?InstanceId=='i-08b37b3894aef9881'].{ID:InstanceId,Ping:PingStatus,Agent:AgentVersion}"
```

### Resultado registrado

```text
Ping: Online
```

### Objetivo/contexto

Verificar se era possível administrar a EC2 pelo AWS Systems Manager.

---

## 6. Diagnóstico do Docker na EC2

### Registro da interação

Foi enviado um comando pelo SSM que retornou:

```text
"Status": "Success"
Docker active
container reservas-api Up
0.0.0.0:3000->3000/tcp
/health: {"status":"ok"}
```

### Objetivo/contexto

Verificar diretamente dentro da EC2 se o Docker, o container e a porta 3000 estavam funcionando.

### Observação

O conteúdo do diagnóstico está registrado, mas o texto integral do comando SSM original não está disponível neste registro. Por isso, o comando não foi reconstruído.

---

## 7. Diagnóstico da conexão com o RDS

### Registro da interação

```text
"Status": "Failed"
"Error": "... nc: command not found ..."
saída: 10.0.12.49 ...
```

### Objetivo/contexto

Testar a comunicação entre a EC2 e o RDS.

### Observação

O registro preserva o resultado da interação, mas não contém o texto integral do comando original.

---

## 8. Confirmação da conectividade com o RDS

### Resultado enviado

```text
RDS_PORT_OPEN
```

### Objetivo/contexto

Confirmar que a EC2 conseguia estabelecer conexão TCP com o RDS na porta 5432.

### Observação

O registro disponível contém o resultado, mas não o comando integral que produziu esse resultado. Por isso, o comando não foi reconstruído.

---

## 9. Testes HTTP da API

### Resultados registrados

```text
HTTP_STATUS:400
```

e

```text
HTTP_STATUS:200
```

### Objetivo/contexto

Validar as respostas HTTP da API durante os testes da prova.

### Observação

Os resultados estão registrados, mas os comandos integrais correspondentes não estão disponíveis no histórico recuperável. Portanto, não foram reconstruídos.

---

## 10. Teste de validação da API

### Resultado registrado

```text
{"error":"Campos obrigatórios não informados"}
```

### Objetivo/contexto

Verificar se a API rejeitava uma requisição sem os campos obrigatórios.

### Observação

O resultado da validação está registrado, mas o texto integral do comando utilizado não está disponível neste registro.

---

## 11. Testes CRUD da API

### Operações registradas

Foram realizados testes envolvendo:

```text
POST /reservas
GET /reservas
GET /reservas/:id
PUT /reservas/:id
DELETE /reservas/:id
```

Também foi registrada a busca de uma reserva inexistente e o envio de dados obrigatórios incompletos.

### Resultados registrados

O histórico registra, entre outros resultados, a criação de reservas com os IDs 4 e 5.

### Objetivo/contexto

Validar o funcionamento do CRUD exigido pela prova.

### Observação

Como os textos integrais de todas as mensagens utilizadas nesses testes não estão preservados no histórico recuperável, não foram criados comandos ou prompts para preencher as partes ausentes.

---

## 12. Validação final e encerramento da infraestrutura

### Resultado registrado

```text
Destroy complete! Resources: 14 destroyed.
```

### Objetivo/contexto

Registrar a conclusão do `terraform destroy`, realizado após as evidências da infraestrutura da prova.

### Observação

Este item representa um resultado registrado da execução. O comando integral utilizado não está reproduzido aqui porque não há segurança de que seu texto original esteja disponível no histórico recuperável.

---

## 13. Conferência do estado final do Git

### Mensagem registrada

```text
main limpa, alinhada a origin/main, commit a3ab822.
```

### Objetivo/contexto

Verificar que o repositório estava organizado e sincronizado antes do encerramento da parte prática.

### Observação

O registro disponível apresenta a informação da conferência, mas não permite recuperar com segurança o texto integral da mensagem original.

---

## 14. Confirmação sobre a conclusão da prova

### Prompt enviado

```text
mas já acabamos a prova?
```

### Objetivo/contexto

Confirmar se todas as etapas práticas da prova já haviam sido concluídas.

---

## 15. Levantamento dos prompts utilizados

### Prompt enviado

```text
Preciso entregar ao professor um levantamento completo de todos os prompts que enviei à IA durante a realização da prova prática de DevOps. Analise todo o histórico desta conversa, do início ao fim, e identifique exclusivamente as mensagens que foram efetivamente enviadas por mim e que tiveram relação direta ou indireta com a realização da prova.
```

### Objetivo/contexto

Solicitar uma forma de levantar os prompts utilizados durante a prova para atender à exigência do professor.

### Observação

Esta mensagem foi enviada posteriormente à execução prática e está relacionada à documentação da prova, por isso foi mantida neste documento e identificada separadamente dos prompts técnicos.

---

# Registros de acompanhamento

Durante a realização da prova também foram enviadas mensagens curtas de acompanhamento, como:

```text
foi
```

Existem várias ocorrências de mensagens desse tipo durante a conversa.

Essas mensagens não foram consideradas prompts técnicos, pois, isoladamente, não permitem identificar qual tarefa ou operação estava sendo solicitada.

---

# Registros cujo conteúdo não deve ser reconstruído

Alguns resultados aparecem no histórico disponível, mas não possuem o prompt ou comando original completo associado a eles. Entre eles estão:

```text
452e5459-3ac2-4e2a-a325-a2a363067e5b
```

```text
RDS_PORT_OPEN
```

```text
HTTP_STATUS:400
```

```text
HTTP_STATUS:200
```

```text
"Status": "Failed"
```

Esses registros são mantidos como evidências do que foi observado durante a execução, mas não são transformados artificialmente em prompts.

---

# Critério utilizado para este levantamento

Foram considerados:

* mensagens enviadas durante a realização da prova;
* comandos utilizados para validação e troubleshooting;
* solicitações relacionadas à API, Docker, Terraform e AWS;
* interações relacionadas à documentação da prova.

Não foram considerados como prompts próprios:

* instruções fornecidas pela IA;
* comandos apenas sugeridos pela IA quando não há registro de que foram enviados;
* trechos de código produzidos originalmente pela IA;
* requisitos da prova apenas apresentados como contexto;
* conclusões ou interpretações feitas pela IA;
* conversas não relacionadas à realização da prova.

O objetivo deste documento é preservar a fidelidade ao histórico disponível. Quando uma mensagem original não está disponível integralmente, ela é identificada como registro parcial em vez de ser reconstruída.

---

# Observação final

Este documento representa os registros que puderam ser recuperados com segurança a partir do histórico disponível. Ele não deve ser interpretado como uma reconstrução dos textos ausentes.

Por esse motivo, alguns itens apresentam o prompt completo, enquanto outros apresentam apenas o resultado ou uma descrição do conteúdo registrado. Essa distinção foi mantida propositalmente para evitar atribuir ao aluno mensagens que não possam ser comprovadas como tendo sido enviadas por ele.
