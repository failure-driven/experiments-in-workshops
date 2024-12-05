describe('navigation of guest book site', () => {
  Cypress.Keyboard.defaults({
    keystrokeDelay: 0,
  })

  it('displays the heading', () => {
    cy.log("When I visit the site")
    cy.visit('http://localhost:3000')

    cy.log("Then I should see the title")
    cy.get('div').should('have.text', 'guest book')
  })
})
