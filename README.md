# Experiminets in Workshop

[![Continous Integration
](https://github.com/failure-driven/experiments-in-workshops/actions/workflows/ci.yml/badge.svg)
](https://github.com/failure-driven/experiments-in-workshops/actions/workflows/ci.yml)

Ideas on how to run a workshop, intially on testing.

## Scenario: AI powered guest book

```gherkin
Given a simple guest book app
When a new guest book entry is added
And the generate AI text option is selected
Then the user is informed that AI is processing the request
When the AI request is complete
Then a number of AI generated guest book entries are presented
When the user accepts an entry
And submits
Then the guest book entry is visible
```

### Setup

```sh
cd guestbook-rails-minimal
bin/setup
bin/rails server
open http://localhost:3000
```

```sh
make
just
just demo-ai

just clean
```

### Guestbook rails minimal

[![Guestbook Rails minimal CI
](https://github.com/failure-driven/experiments-in-workshops/actions/workflows/guestbook-rails-minimal-ci.yml/badge.svg)
](https://github.com/failure-driven/experiments-in-workshops/actions/workflows/guestbook-rails-minimal-ci.yml)

```sh
cd guestbook-rails-minimal
just build
```

### Plain old coding dojo

1. choose a problem
    1. from a kata site
        1. http://codekata.com/
        1. https://github.com/gamontal/awesome-katas
        1. https://codingdojo.org/kata/
    1. formulate own problem
        1. **Given** some `state`
        1. **When** some `action` is performed
        1. **Then** some `result` can be asserted
1. create a folder or repo
   ```sh
   mkdir dojo
   git init
   # OR
   git clone git@github.com:failure-driven/dojo.git

    # AND
   mkdir `date +%F`-name-of-kata
   ```
1. setup ruby, rspec and a first test
   ```sh
   cd ... # directory created above

   # setup a ruby version
   asdf local ruby 3.3.0

   # initalize bundler for gem managment
   bundle init

   # add rspec gem
   bundle add rspec

   # initialize rspec
   bundle exec rspec --init

   # run rspec
   bundle exec rspec

   # create a dummy test and run it
   cat << EOF > spec/first_spec.rb
   RSpec.describe "first test" do
     it "runs" do
       expect(true).to be_truthy
     end
   end
   EOF

   # run it
   bundle exec rspec

   # switch to documentation format and run it
   echo "--format documentation" >> .rspec
   bundle exec rspec

   # create a lib directory for your implementation
   mkdir lib
   # create a class
   cat << EOF > lib/first.rb
   class First
   end
   EOF

   # make sure to require it in your spec
   # in spec/first_spec.rb
   require 'first'
   ```

1. TDD (Test Driven Development): red -> green -> refactor

   ```mermaid
   flowchart LR
       Red["❌ Red"] --> Green["✅ Green"]
       Green --> Refactor["♻ Refactor"]
       Refactor --> Red 
   ```

    1. Break the problem into first smallest chunk
    1. Write a failing test ❌ red
    1. Shamelessly implement as quickly as possible ✅ Green
    1. ♻ Refactor
        1. DRY - don't repeat yourself
        1. Both the code and the tests
        1. DAMP tests - Descriptive and Meaningful Phrases
        1. SOLID principles
            1. **S**ingle responsiblity
            1. **O**pen close
            1. **L**iskov substition
            1. **I**nterface segregation
            1. **D**ependency inversion
        1. others ...

1. Outside in BDD and TDD, BDD (Behaviour Driven Development):
   from the user perspective and TDD from the unit perspective

```mermaid
flowchart LR
    fRed["❌ Red Behaviour"] --> Red
    Red["❌ Red"] --> Green["✅ Green"]
    Green --> Refactor["♻ Refactor"]
    Refactor --> Red
    Refactor --> fGreen
    fGreen["✅ Green Behaviour"]
    fGreen --> fRefactor["♻ Refactor System"]
    fRefactor --> fRed
```

#### Extras

- [co authors](./docs/co_authors.md)
- [watch specs with guard](./docs/watch_specs.md)
- [runnable command](./docs/runnable_command.md)
- [end-to-end tests](./docs/end_to_end_tests.md)
- [rubocop for linting](./docs/rubocop.md)
- [Makefile](./docs/makefile.md)
- [justfile](./docs/justfile.md)
- [LOL commits](./docs/lol_commits.md)

**Use it in rails**

```sh
rails new my-new-rails-project \
    --skip-git \
    --minimal \
    --database=postgresql \
    --template rails_setup/rails_with_testing_template.rb

cd my-new-rails-project

# generate a root controller
rails generate controller Welcome index \
    --no-helper \
    --test-framework=rspec

sed -i .old '/# root/s/# root.*$/root "welcome#index"/' config/routes.rb
rm config/routes.rb.old

# switch a dojo thing into a gem
cat << EOF > my_dojo_thing.gemspec
Gem::Specification.new do |s|
  s.name        = "my_dojo_thing"
  s.version     = "0.0.1"
  s.summary     = "Substring context"
  s.authors     = ["mob code session"]
  s.files       = ["lib/my_dojo_thing.rb"]
end
EOF

# and build it
gem build my_dojo_thing.gemspec

# add it as a dependency in Gemfile
bundle add my_dojo_thing --path "../../dojo/my_dojo_thing"
# alternately if you have a date or other cruft
bundle add my_dojo_thing --path "../../dojo/YYYY-MM-DD-my_dojo_thing"

# and use it in the controller
  def index
    @input = params[:input]
    my_dojo_thing = MyDojoThing.new
    @output = my_dojo_thing.action(@input)
  end

# and view
  <%= form_with url: root_path, method: :get do |form| %>
    <div>
      <%= form.label :input %>
      <%= form.text_area :input, value: @input %>
    </div>
    <div>
      <%= form.submit :submit %>
    </div>
  <% end %>

  <% if @output %>
    <textarea>
      <%= @output %>
    </textarea>
  <% end %>
```

### Next Steps

- [ ] basic rails project to add an AI guestbook button to
    - [ ] maybe using a rails generator template?
    - [ ] myabe added as a rails engine?
- [ ] fine tune the use of an AI backend?
    - [ ] use a key for OpenAI?
    - [ ] fine tune the **ollama** grammer?
        - https://github.com/crimson-knight/llamero
        - also take a look at a grammer PR
          https://github.com/ollama/ollama/pull/1606
    - [ ] take a look at the **falcon** example
        - https://github.com/socketry/falcon-rails-example/commit/965c72052c88c3b213f58c0f0056a1a30201cb0b

## Random thoughs

- [ ] how to deal with environment setup
    - [ ] github code spaces?
- [ ] how to deal with transitioning in code updates, student created vs
  requried for the next section
    - [ ] branches
    - [ ] patches
    - [ ] separate directory? packwerk package for rails?
- [ ] basic "Outside in BDD" workshop
    - the hypothesis is
    > "lot's of new people to the industry know how to code, but they don't
    > know how to get started to build out a complete product"
    - [ ] demonstrate how BDD flow can benefit an existing application - "add
      AI messages to guest book"
    - [ ] use AI chat to generate a general set of acceptance criteria for the
      product: blog, marketplace, social platform, etc
    - [ ] basic setup for BDD/TDD web in your platform of choice: Rails,
      Node(Next? other?), Angular + API, etc
    - [ ] drive out the first flow and associated TDD unit specs
    - [ ] cover off CRUD, background jobs, external services and hexagonal
      architecture
    - [ ] touch on microservices and contract testing
    - [ ] other kinds of testing - property based, random
    - [ ] tracking business level success throught statsd/OpenTelemetry?
