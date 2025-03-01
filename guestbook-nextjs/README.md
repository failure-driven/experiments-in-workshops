# NextJS workshop

## start

### Write a comment

```ruby
Given I am on the guestbook
When I write a comment, with my name
Then I see a success message
And I see my comment
```

### Deal with errors

```ruby
When I submit an empty comment, with my name
Then I see an error message, that comment is mandatory
When I update the comment and submit
Then I see a success message
And I see my comment
```

- [ ] validation at JS layer - empty message
- [ ] validation at API layer - rude words?

### Deal with errors at component level

```ruby
When the server throws a 500 error
Then the error message is displayed
```

```ruby
When the server takes too long to respond
Then the error message is displayed
```

```ruby
When the submit button is pressed for an API call
Then a spinner is shown
When the API call completes
Then the spinner is hidden
```

## Lab 1

JS unit testing approach
Problem: personalize your text output page
Simple, immaterial changes to functionality.
Focus on isolated JS unit test
Recap, discuss, Q&A

## Lab 2

BDD testing approach
Problem: add a specific validation to the initial form
Basic, isolated change to functionality
Challenge participants to think of different validations & how they might be displayed
Recap, discuss, Q&A

## Lab 3

```ruby
Given I am on the guestbook
When I write a comment, with my name
Then I see a success message
And I see my comment
And an option to get an AI generated comment
When I ask for the AI comment
Then I see a spinner as it is working
And finally I see a response
When I choose to display the AI generated comment
Then I see a success message
And the AI generated comment is displayed in the guestbook
```

BDD vs TDD testing boundaries
Problem: add AI enhancement & background job
A complex change with extra moving parts
BDD as the primary focus
Optionally extend (time permitting)
TDD the worker
Challenge participants to think of considerations for running background jobs
TDD the AI service
Recap, discuss, Q&A

