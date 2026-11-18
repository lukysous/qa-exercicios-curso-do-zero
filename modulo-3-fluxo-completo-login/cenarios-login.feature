# language: pt
Funcionalidade: Login no sistema
  Como usuário cadastrado
  Quero fazer login com meu usuário e senha
  Para acessar a Área Segura

  Cenário: Login com usuário e senha válidos
    Dado que o usuário esteja na tela de login
    Quando o usuário preenche o campo "Username" com "tomsmith"
    E preenche o campo "Password" com "SuperSecretPassword!"
    E clica no botão "Login"
    Então o usuário é direcionado para a Área Segura
    E deve ser exibida a mensagem "You logged into a secure area!"
    E deve ser exibido o botão "Logout"
    Mas não deve ser exibida nenhuma mensagem de erro

  Cenário: Login com senha errada
    Dado que o usuário esteja na tela de login
    Quando o usuário preenche o campo "Username" com "tomsmith"
    E preenche o campo "Password" com "senhaErrada123"
    E clica no botão "Login"
    Então o usuário deve permanecer na tela de login
    E deve ser exibida a mensagem "Your password is invalid!"
    Mas não deve ter acesso à Área Segura

  Cenário: Login com usuário inexistente
    Dado que o usuário esteja na tela de login
    Quando o usuário preenche o campo "Username" com "usuarioinexistente"
    E preenche o campo "Password" com "SuperSecretPassword!"
    E clica no botão "Login"
    Então o usuário deve permanecer na tela de login
    E deve ser exibida a mensagem "Your username is invalid!"
    Mas não deve ter acesso à Área Segura

  Cenário: Login com campos vazios
    Dado que o usuário esteja na tela de login
    Quando o usuário deixa os campos "Username" e "Password" vazios
    E clica no botão "Login"
    Então o usuário deve permanecer na tela de login
    E deve ser exibida a mensagem "Your username is invalid!"
    Mas não deve ter acesso à Área Segura
