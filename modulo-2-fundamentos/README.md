# Módulo 2 – Fundamentos: classificando bugs e tipos de teste

Missão prática do **Curso QA do Zero**. Naveguei por uma loja virtual feita de propósito com bugs escondidos, encontrei 6 problemas e classifiquei cada um: se é **defeito, falha ou incidente**, qual **tipo de teste** o encontraria e em qual **nível de teste** ele seria pego.

| | |
|---|---|
| Autor | Lucas Souza |
| Quando testei | Outubro de 2026 |
| Sistema testado | [AcademyBugs](https://academybugs.com/find-bugs/), loja de prática com bugs escondidos |
| Tipo de teste | Manual, exploratório |
| Onde testei | Computador com Windows 10 e Google Chrome |

Análise completa em PDF: [Analise_de_Bugs_Modulo2.pdf](Analise_de_Bugs_Modulo2.pdf)

> Nos prints, escondi meus dados pessoais (e-mail, endereço e telefone) com uma tarja cinza.

---

## Os conceitos que usei

| Conceito | O que é | Exemplo do dia a dia |
|---|---|---|
| **Defeito** | O erro que está no código ou na construção do sistema | A receita do bolo está escrita errada |
| **Falha** | O comportamento errado que a pessoa vê quando usa o sistema | O bolo sai solado |
| **Incidente** | Quando a falha chega em produção e atrapalha pessoas reais | O bolo solado é vendido para o cliente |

Todo problema que vi na tela é uma **falha**, causada por um **defeito** no código. Como encontrei tudo durante um teste, em um site de prática, nenhum deles chegou a afetar clientes reais. Por isso nenhum foi classificado como incidente. Classifiquei como **defeito** quando o problema está no próprio conteúdo, ou seja, o erro está escrito ali e não depende de nenhuma ação para aparecer.

---

## Tabela de análise

| # | Problema encontrado | Evidência | Classificação | Tipo de teste | Nível de teste |
|---|---|---|---|---|---|
| 1 | O endereço de cobrança fica carregando para sempre na página da conta | [print](prints/01-endereco-cobranca-carregando.png) | Falha | Funcional | Integração |
| 2 | A quantidade do produto no carrinho não passa de 2 | [print](prints/02-quantidade-maxima-2.png) | Falha | Funcional | Unitário |
| 3 | Na seção "Novo Usuário", parte do texto aparece em russo | [print](prints/03-texto-em-russo.png) | Defeito | Conteúdo | Sistema |
| 4 | O botão "Entrar" da área "Sua Conta" fica por cima do rodapé | [print](prints/04-login-cobrindo-rodape.png) | Falha | Interface | Sistema |
| 5 | Clicar no fabricante do produto leva para uma página de erro 404 | [print](prints/05-fabricante-erro-404.png) | Falha | Funcional | Integração |
| 6 | Ao postar um comentário no produto, o site trava | [print](prints/06-comentario-trava-site.png) | Falha | Funcional | Integração |

---

## Justificativas

**1. Endereço de cobrança carregando para sempre**
- **Classificação (falha):** eu, como usuário, vejo a tela girando sem parar e nunca recebo o endereço. A causa é um defeito no código que busca esse dado.
- **Tipo (funcional):** a função "mostrar meu endereço de cobrança" não funciona.
- **Nível (integração):** a tela precisa pedir o endereço para outra parte do sistema (o cadastro ou o servidor). O problema aparece na conversa entre essas partes.

**2. Quantidade não passa de 2**
- **Classificação (falha):** clico no "+" e a quantidade não aumenta além de 2. É um comportamento errado que o cliente percebe.
- **Tipo (funcional):** a regra de alterar a quantidade não funciona como deveria.
- **Nível (unitário):** a regra "quantidade máxima" é um pedaço pequeno e isolado do código. Um teste unitário dessa função já pegaria o limite errado.
- **Observação extra:** no mesmo print, o **Total geral ($ 138,27)** não bate com a conta. O subtotal ($ 30,28) mais o frete ($ 7,99) dá **$ 38,27**, uma diferença de $ 100,00. Esse é um segundo problema, que eu reportaria separado.

**3. Texto em russo na seção "Novo Usuário"**
- **Classificação (defeito):** o texto errado ("Нажмите кнопку ниже", que significa "clique no botão abaixo") está escrito no próprio site. É um erro de construção do conteúdo. Não depende de nenhuma ação do usuário para aparecer.
- **Tipo (conteúdo):** o problema é o texto, não o funcionamento. O link continua funcionando.
- **Nível (sistema):** o erro aparece quando olho a página pronta, como o usuário vê.

**4. Botão "Entrar" por cima do rodapé**
- **Classificação (falha):** o usuário vê o botão invadindo o rodapé, o que deixa a página bagunçada e pode atrapalhar o clique nos links do rodapé.
- **Tipo (interface):** é um problema de layout, de onde os elementos ficam na tela.
- **Nível (sistema):** só dá para ver com a página inteira montada, com todos os blocos juntos.

**5. Erro 404 ao clicar no fabricante**
- **Classificação (falha):** o usuário clica num link e cai numa página que não existe.
- **Tipo (funcional):** o link não leva para onde deveria.
- **Nível (integração):** o problema está na ligação entre a página do produto e a página do fabricante. O link aponta para um endereço que não existe.

**6. Site trava ao postar comentário**
- **Classificação (falha):** ao clicar em "Postar comentário", o site trava e o próprio site avisa que encontrei um erro de travamento. Numa loja real, isso viraria um **incidente**, porque todo cliente que tentasse comentar travaria o site.
- **Tipo (funcional):** a função de comentar não funciona.
- **Nível (integração):** o comentário precisa ser enviado e salvo no servidor. O travamento acontece nessa comunicação.

---

## O que aprendi

Aprendi que nem todo problema é igual. Separar **defeito, falha e incidente** ajuda a explicar para o time onde está o erro e qual o tamanho do impacto. Pensar no **tipo** e no **nível** de teste mostra em que momento o problema poderia ter sido pego mais cedo e mais barato: o limite de quantidade, por exemplo, um teste unitário pegaria antes de qualquer pessoa abrir a loja.

---

## O que tem nesta pasta

```
modulo-2-fundamentos/
├── README.md                        ← este resumo
├── Analise_de_Bugs_Modulo2.pdf      ← a tabela de análise completa
└── prints/                          ← evidência de cada problema (dados pessoais ocultos)
```
