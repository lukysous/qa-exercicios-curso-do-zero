# Módulo 6 – Ferramentas: API, banco de dados e a primeira automação

Missão prática do **Curso QA do Zero**. Neste módulo testei uma API no Postman, validei dados com SQL e criei o meu primeiro teste automatizado com Cypress.

| | |
|---|---|
| Autor | Lucas Souza |
| Quando fiz | Novembro de 2026 |
| Ferramentas | Postman · SQL · Cypress · Node.js |
| Onde testei | Computador com Windows 10 |

---

## Resumo

| Parte | O que fiz | Resultado |
|---|---|---|
| A · API | GET, POST e cenários de erro no Postman | 3 passaram, 1 bloqueado pelo limite da API |
| B · Banco de dados | Consultas de validação com SQL | Todas executadas |
| C · Automação | Teste de login com Cypress | ✅ Passou |

---

## Parte A – Teste de API no Postman

APIs usadas: [JSONPlaceholder](https://jsonplaceholder.typicode.com) e [ReqRes](https://reqres.in).

| Tarefa | Requisição | Esperado | Obtido | Status | Print |
|---|---|---|---|---|---|
| 1 | `GET /users/1` | 200 | 200 OK | ✅ Passou | [T1-GET-users-1-200.png](postman/T1-GET-users-1-200.png) |
| 2 | `GET /users/9999` | 404 | 404 Not Found | ✅ Passou | [T2-GET-users-9999-404.png](postman/T2-GET-users-9999-404.png) |
| 3 | `POST /users` | 201 | 201 Created | ✅ Passou | [T3-POST-users-201.png](postman/T3-POST-users-201.png) |
| 4 | `POST /api/login` sem senha | 400 | 429 Too Many Requests | ⚠️ Bloqueado | [T4-POST-login-429.png](postman/T4-POST-login-429.png) |

**Tarefa 1 · GET de um usuário que existe.** A API respondeu 200 OK, ou seja, o pedido deu certo e o usuário existe. Validei que os campos esperados vieram preenchidos: nome (Leanne Graham), e-mail (Sincere@april.biz) e telefone (1-770-736-8031 x56442).

**Tarefa 2 · GET de um usuário que não existe.** A API respondeu 404 Not Found, com o corpo vazio `{}`. Esse é o comportamento correto: o usuário 9999 não existe, e quando o recurso pedido não existe a API deve avisar que não encontrou. Seria um bug se ela respondesse 200 (fingindo que achou) ou 500 (erro no servidor).

**Tarefa 3 · POST criando um usuário.** Enviei `{ "name": "Maria Teste", "email": "maria@teste.com" }`. A API respondeu 201 Created e devolveu o usuário criado com o ID gerado (`"id": 11`).

**Tarefa 4 · Login sem senha no ReqRes.** O esperado era 400 Bad Request com a mensagem `"Missing password"`, porque a senha é obrigatória. O obtido foi **429 Too Many Requests**: a versão gratuita da API aceita 40 requisições por dia por IP, e esse limite já tinha acabado. A requisição estava montada corretamente (método, URL, cabeçalho `x-api-key` e body). O 429 é uma proteção chamada *rate limit*, que impede que alguém sobrecarregue o servidor. Registrei o teste como **bloqueado por limite da API**, e não como defeito.

---

## Parte B – Validação em banco de dados (SQL)

Banco usado: [W3Schools – Try SQL](https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all), tabela `Customers`.

| Tarefa | Consulta | Retornou | Print |
|---|---|---|---|
| 5 | `SELECT * FROM Customers;` | 91 clientes, todas as colunas | [T5-select-todos.png](banco-de-dados/T5-select-todos.png) |
| 5 | `SELECT CustomerName, City, Country FROM Customers;` | 91 clientes, só 3 colunas | [T5-select-colunas.png](banco-de-dados/T5-select-colunas.png) |
| 6 | `SELECT * FROM Customers WHERE Country = 'Brazil';` | 9 clientes do Brasil | [T6-where-brazil.png](banco-de-dados/T6-where-brazil.png) |
| 6 | `SELECT CustomerName, Country FROM Customers ORDER BY CustomerName;` | 91 clientes em ordem alfabética | [T6-order-by.png](banco-de-dados/T6-order-by.png) |
| 6 | `SELECT COUNT(*) AS Total FROM Customers;` | Total = 91 | [T6-count.png](banco-de-dados/T6-count.png) |
| 7 | `SELECT Country, COUNT(*) AS Total FROM Customers GROUP BY Country ORDER BY Total DESC;` | Quantidade de clientes por país | [T7-group-by.png](banco-de-dados/T7-group-by.png) |

**Por que cada consulta é útil para um QA** (anotação completa em [Anotacao_Tarefa_6.docx](banco-de-dados/Anotacao_Tarefa_6.docx)):

- **SELECT:** depois de testar um cadastro na tela, confiro no banco se os dados foram salvos de verdade, olhando só as colunas que me interessam.
- **WHERE:** acho um registro específico, por exemplo para conferir se o cliente que cadastrei no teste foi salvo com o país certo.
- **ORDER BY:** organizo a lista e confiro se a ordenação mostrada na tela é a mesma do banco.
- **COUNT:** confiro quantidades. Se havia 91 clientes e eu cadastrei um no teste, o total tem que virar 92. Se continuar 91, o cadastro não foi salvo, e é bug.

**Tarefa 7 · GROUP BY e duplicatas.** O `GROUP BY Country` junta os clientes pelo país e o `COUNT(*)` conta quantos há em cada grupo. Com o `ORDER BY Total DESC`, o país com mais clientes aparece primeiro.

Para achar **cadastros duplicados** num teste real, eu agruparia pelo campo que deveria ser único (e-mail, CPF ou nome) e mostraria só os grupos com mais de um registro:

```sql
SELECT CustomerName, COUNT(*) AS Vezes
FROM Customers
GROUP BY CustomerName
HAVING COUNT(*) > 1;
```

Se essa consulta trouxer alguma linha, existe cadastro duplicado, e isso é um bug para reportar.

---

## Parte C – Primeira automação com Cypress

Pasta: [automacao-cypress](automacao-cypress)

Criei um teste automatizado para o login do site [The Internet](https://the-internet.herokuapp.com/login). O teste:

1. acessa a página de login;
2. preenche o usuário e a senha de teste (publicados na própria página do site);
3. clica no botão Login;
4. valida que a mensagem **"You logged into a secure area!"** apareceu.

**Resultado:** ✅ passou. Print: [T8-cypress-login-passou.png](automacao-cypress/T8-cypress-login-passou.png)

```javascript
describe('Login no The Internet', () => {
  it('faz login com usuário e senha válidos', () => {
    cy.visit('https://the-internet.herokuapp.com/login')
    cy.get('#username').type('tomsmith')
    cy.get('#password').type('SuperSecretPassword!')
    cy.get('button[type="submit"]').click()
    cy.get('#flash').should('contain', 'You logged into a secure area!')
  })
})
```

**Dificuldade que resolvi:** na primeira vez o Cypress não abriu, por causa de uma permissão do Windows na pasta onde ele fica instalado. Li a mensagem de erro, entendi a causa e apliquei a correção que o próprio erro indicava (o comando `icacls`). Depois disso o teste rodou normalmente.

### Como rodar o teste

```bash
cd automacao-cypress
npm install
npx cypress open
```

---

## O que aprendi

Nesse módulo percebi que testar não é só clicar na tela. Pela API eu consigo testar o sistema "por trás", mais rápido e sem depender da interface. Com SQL eu confiro se o que aparece na tela foi mesmo salvo no banco. E com o Cypress vi que um teste que eu fazia na mão pode virar um robô que repete o mesmo teste sempre que o sistema mudar. Também aprendi a registrar um teste bloqueado com honestidade, explicando o motivo, em vez de esconder o resultado.

---

## O que tem nesta pasta

```
modulo-6-ferramentas/
├── README.md                  ← este resumo
├── postman/                   ← prints das Tarefas 1 a 4
├── banco-de-dados/            ← prints e anotação das Tarefas 5 a 7
└── automacao-cypress/         ← projeto Cypress da Tarefa 8
    ├── cypress/e2e/login.cy.js
    ├── cypress.config.js
    ├── package.json
    └── T8-cypress-login-passou.png
```
