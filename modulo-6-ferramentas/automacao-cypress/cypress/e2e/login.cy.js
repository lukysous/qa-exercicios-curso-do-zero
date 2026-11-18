// Tarefa 8 · Teste de login no The Internet

describe('Login no The Internet', () => {
  it('faz login com usuário e senha válidos', () => {
    // 1. Acessar a página de login
    cy.visit('https://the-internet.herokuapp.com/login')

    // 2. Preencher o usuário e a senha
    cy.get('#username').type('tomsmith')
    cy.get('#password').type('SuperSecretPassword!')

    // 3. Clicar no botão Login
    cy.get('button[type="submit"]').click()

    // 4. Validar que a mensagem de sucesso apareceu
    cy.get('#flash').should('contain', 'You logged into a secure area!')
  })
})
