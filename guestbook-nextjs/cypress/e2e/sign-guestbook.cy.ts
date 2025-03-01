describe("sign guestbook", () => {
  // TODO: move to defaults
  Cypress.Keyboard.defaults({
    keystrokeDelay: 0,
  });

  it("Add a comment to the guestbook", () => {
    // TODO: have a clear DB command
    cy.log("Given I re-seed the site database");
    // TODO: move to environment and change to TEST_PORT
    cy.request("http://localhost:3000/seed");

    cy.log("When I visit the site");
    cy.visit("http://localhost:3000");

    cy.log("And I choose to create a new comment");
    cy.get("a[data-testid=new-comment]").click();

    cy.log("And I enter a valid comment and my details");
    cy.get("input[name=email]").type("me@example.com");
    cy.get("input[name=name]").type("Me");
    cy.get("input[name=last-name]").type("Me with a capital M");
    cy.get("textarea[name=comment]").type("Me with a capital M");
    cy.get("button[type=submit]").click();

    cy.log("Then I am informed the operation was a success")
    // TODO: view a flash message

    // TODO: test for 422 server validation
    // TODO: test for 500 server error

    cy.log("And the message is dispalyed on the guestbook");
    // TODO: move to a page object
    // TODO: find by email || ID
    cy.get("[data-testid=comment-list] [data-testid=comment-email]")
      .then(($element) =>
        Array.from($element.map((_index, el) => el.textContent)),
      )
      .then((result) =>
        expect(result[result.length - 1]).to.equal("me@example.com"),
      );
  });

  it("Add a comment to the guestbook requires an email", () => {
    // TODO: have a clear DB command
    cy.log("Given I re-seed the site database");
    // TODO: move to environment and change to TEST_PORT
    cy.request("http://localhost:3000/seed");

    cy.log("When I visit the site");
    cy.visit("http://localhost:3000");

    cy.log("And I choose to create a new comment");
    cy.get("a[data-testid=new-comment]").click();

    cy.log("And I enter a comment without an email");
    cy.get("input[name=name]").type("Me");
    cy.get("input[name=last-name]").type("Me with a capital M");
    cy.get("textarea[name=comment]").type("Me with a capital M");
    cy.get("button[type=submit]").click();

    cy.log("Then I am informed the operation was unprocessable")
    // TODO: view a flash message

    // TODO: test for 422 server validation
    // TODO: test for 500 server error

    cy.log("When I update the form with an email");
    cy.get("input[name=email]").type("me@example.com");

    cy.log("And I submit");
    cy.get("button[type=submit]").click();

    cy.log("Then I am informed the operation was a success")
    // TODO: view a flash message

    cy.log("And the message is dispalyed on the guestbook");
    // TODO: move to a page object
    // TODO: find by email || ID
    cy.get("[data-testid=comment-list] [data-testid=comment-email]")
      .then(($element) =>
        Array.from($element.map((_index, el) => el.textContent)),
      )
      .then((result) =>
        expect(result[result.length - 1]).to.equal("me@example.com"),
      );
  });
});
