# End-to-End test

of a runnable command (see [runnable_command.rb](./runnable_command.rb)

```sh
# create a feature spec directory and a feature spec that runs bin/run.rb
mkdir spec/features
cat << EOF > spec/features/feature_spec.rb
require "spec_helper"

feature "simple features" do
  let(:runner) { File.join(__dir__, "../../bin/run.rb") }

  scenario "runs successfully" do
    When "the runner is run" do
      @result = `bundle exec ruby #{runner} arg_1 arg_2`
    end

    Then "the result is as expected" do
      expect(@result).to eq(
        <<~EO_REPORT_OUTPUT
          ["arg_1", "arg_2"]
        EO_REPORT_OUTPUT
      )
    end
  end
end
EOF
```

Some RSpec configuration in `spec/spec_helper.rb`

```sh
# configure spec/spec_helper.rb to allow feature and scenario naming
RSpec.configure do |config|
  ...
  # add the Capybara like feature and scenario to make the spec/features read
  # more like BDD specs as per
  #   https://github.com/teamcapybara/capybara/blob/master/lib/capybara/rspec/features.rb
  RSpec.configure do |config|
    config.alias_example_group_to :feature, :capybara_feature, type: :feature
    config.alias_example_group_to :xfeature, :capybara_feature, type: :feature,
      skip: "Temporarily disabled with xfeature"
    config.alias_example_group_to :ffeature, :capybara_feature, :focus, type:
      :feature
    config.alias_example_to :scenario
    config.alias_example_to :xscenario, skip: "Temporarily disabled with xscenario"
    config.alias_example_to :fscenario, :focus
  end

# add rspec example steps Given/When/Then gem
bundle add rspec-example_steps
# configure spec/spec_helper.rb to allow Given/When/Then output
require "rspec/example_steps"
...
RSpec.configure do |config|
  ...
  # as per https://github.com/railsware/rspec-example_steps/issues/14
  RSpec::Core::Formatters.register(
    RSpec::Core::Formatters::DocumentationFormatter,
    :example_group_started,
    :example_group_finished,
    :example_passed,
    :example_pending,
    :example_failed,
    :example_started,
    :example_step_passed,
    :example_step_pending,
    :example_step_failed
  )
```
