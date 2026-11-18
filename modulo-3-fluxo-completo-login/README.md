# Módulo 3 – Fluxo completo de teste: tela de login

Missão prática do **Curso QA do Zero**. Neste módulo fiz o ciclo de teste completo de uma funcionalidade, do planejamento ao bug report: planejei o que testar, escrevi os casos de teste e os cenários em BDD, executei e registrei o bug que encontrei.

| | |
|---|---|
| Autor | Lucas Souza |
| Quando testei | Outubro de 2026 |
| Sistema testado | [The Internet – Login](https://the-internet.herokuapp.com/login), um site público feito para treinar teste |
| Tipo de teste | Manual |
| Onde testei | Computador com Windows 10 e Google Chrome |

---

## 1. Planejamento de qualidade

Arquivo: [Planejamento_de_Qualidade_Login.docx](Planejamento_de_Qualidade_Login.docx)

O login é a porta de entrada da área restrita do sistema. Se ele falhar, o usuário não entra. Se aceitar dados errados, alguém sem permissão pode entrar. Por isso tratei como uma funcionalidade **crítica**.

O objetivo foi verificar se o login funciona no cenário positivo (usuário e senha válidos) e nos negativos (senha errada, usuário que não existe e campos vazios), e se as mensagens mostradas ao usuário estão claras e corretas.

## 2. O que vale testar (e o que ficou de fora)

Arquivo: [Analise_O_Que_Vale_Testar.docx](Analise_O_Que_Vale_Testar.docx)

| | |
|---|---|
| **Priorizei** | Login válido e os três erros mais comuns: senha errada, usuário inexistente e campos vazios |
| **Ficou de fora** | Segurança avançada (força bruta, SQL Injection), performance, outros navegadores e celular |
| **Risco de não testar** | O login pode falhar em outros navegadores ou com muitos acessos ao mesmo tempo sem ninguém perceber |

Deixar algo de fora foi uma decisão consciente: o foco deste ciclo era o funcionamento básico, no Chrome. Registrar o que ficou de fora mostra para o time qual risco continua aberto.

## 3. Casos de teste

Arquivos: [Casos_de_Teste_Login.docx](Casos_de_Teste_Login.docx) e [Caderno_de_Teste_Login.xlsx](Caderno_de_Teste_Login.xlsx)

| Caso | O que testei | Resultado esperado |
|---|---|---|
| CT01 | Login com usuário e senha válidos | Vai para a Secure Area com a mensagem "You logged into a secure area!" |
| CT02 | Login com senha errada | Continua no login com a mensagem "Your password is invalid!" |
| CT03 | Login com usuário que não existe | Continua no login com a mensagem "Your username is invalid!" |
| CT04 | Login com os campos vazios | Continua no login com a mensagem "Your username is invalid!" |

## 4. Cenários em BDD (Gherkin)

Arquivos: [cenarios-login.feature](cenarios-login.feature) e [Cenarios_BDD_Login.docx](Cenarios_BDD_Login.docx)

Escrevi os mesmos quatro casos como cenários em Gherkin (Dado / Quando / Então), uma linguagem que o QA, o dev e o PO conseguem ler juntos. O arquivo `.feature` pode ser aberto direto aqui no GitHub.

## 5. Bug encontrado: BUG-001

Arquivo: [Bug_Report_BUG-001.docx](Bug_Report_BUG-001.docx)

**A mensagem de erro do login revela se o usuário existe ou não.**

Com um usuário que não existe, aparece "Your username is invalid!". Com um usuário que existe e a senha errada, aparece "Your password is invalid!". Só de olhar a mensagem, qualquer pessoa descobre quais usuários estão cadastrados e pode concentrar as tentativas só na senha.

| Severidade | Prioridade | Tipo |
|---|---|---|
| Baixa: o login funciona e ninguém entra sem a senha certa | Média: envolve a segurança da conta | Melhoria / Segurança |

O esperado seria uma mensagem única para qualquer erro de login, como "Usuário ou senha inválidos".

---

## O que tem nesta pasta

```
modulo-3-fluxo-completo-login/
├── README.md                              ← este resumo
├── Planejamento_de_Qualidade_Login.docx   ← planejamento do ciclo
├── Analise_O_Que_Vale_Testar.docx         ← prioridades e riscos
├── Casos_de_Teste_Login.docx              ← CT01 a CT04 detalhados
├── Caderno_de_Teste_Login.xlsx            ← execução dos casos
├── cenarios-login.feature                 ← cenários BDD em Gherkin
├── Cenarios_BDD_Login.docx                ← os mesmos cenários em Word
└── Bug_Report_BUG-001.docx                ← bug de segurança no login
```
