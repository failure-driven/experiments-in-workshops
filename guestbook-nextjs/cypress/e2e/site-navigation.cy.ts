describe("navigation of guest book site", () => {
  Cypress.Keyboard.defaults({
    keystrokeDelay: 0,
  });

  it("displays the heading", () => {
    cy.log("Given I re-seed the site database");
    cy.request("http://localhost:3000/seed");

    cy.log("When I visit the site");
    cy.visit("http://localhost:3000");

    cy.log("Then I should see the title");
    cy.get("h1").should("have.text", "guest book");

    cy.log("When I choose to create a new comment");
    cy.get("a[data-testid=new-comment]").click();

    // TODO: test for form being invalid

    cy.log("And I enter a valid comment and my details");
    cy.get("input[name=email]").type("me@example.com");
    cy.get("input[name=name]").type("Me");
    cy.get("input[name=last-name]").type("Me with a capital M");
    cy.get("textarea[name=comment]").type("Me with a capital M");
    cy.get("button[type=submit]").click();

    // TODO: test for 422 server validation
    // TODO: test for 500 server error

    // TODO: view a flash message

    cy.log("Then the message is dispalyed on the guestbook");
    cy.get("ul[data-testid=comment-list] > li")
      .then(($element) =>
        Array.from($element.map((_index, el) => el.textContent)),
      )
      .then((result) =>
        expect(result[result.length - 1]).to.equal(
          "me@example.com, Me, Me with a capital M",
        ),
      );

    // TODO: edit the message TODO: spinner TODO: make background call to get an
    // AI message, probably in aiComment field with a flag to use the field or
    // not
  });
});
