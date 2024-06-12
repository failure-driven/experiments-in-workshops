# if using --skip-git would need some of this
unless File.exist?(".gitignore")
  file ".gitignore", <<~EO_GITIGNORE
    /.bundle
    /.env*
    !/.env*.erb
    /log/*
    /tmp/*
    /storage/*
    /public/assets
    /config/master.key
  EO_GITIGNORE
end

after_bundle do
  git add: "."
  git commit: "-a -m '🎉 Rails new'"

  gem_group :test do
    # gem "capybara", "~> 3.40" # included in rails
    gem "capybara-inline-screenshot", "~> 2.2"
    gem "rspec-example_steps", "~> 3.1"
    gem "rspec-rails", "~> 6.1"
    gem "site_prism" # dependent on above capybara? , "~> 5.0"
    gem "webdrivers", "~> 5.3"
  end

  gem_group :development do
    gem "rubocop-capybara", "~> 2.20", require: false
    gem "rubocop-performance", "~> 1.21", require: false
    gem "rubocop-rails", require: false # version set by capybara
    gem "rubocop-rake", "~> 0.6.0", require: false
    gem "rubocop-rspec", "~> 2.29", require: false
    gem "standard", "~> 1.36", require: false
  end

  # setup
  run "bin/setup"

  # generate rspec setup
  run "rails generate rspec:install"
  # create bin/rspec binstub
  run "bundle binstubs rspec-core"
  # uncomment the loading of spec/support files
  run "sed -i .old '/Rails.root.glob..spec.support/s/^# //g' spec/rails_helper.rb"
  run "rm spec/rails_helper.rb.old"
  # append documentation format for rspec preferences
  run 'echo "--format documentation" >> .rspec'

  # TODO: shhould be wrapped
  # if Rails.env.test?
  #   # a test only route used by spec/features/it_works_spec.rb
  #   get "test_root", to: "rails/welcome#index", as: "test_root_rails"
  # end
  route 'get "test_root", to: "rails/welcome#index", as: "test_root_rails"'

  file "spec/features/it_works_spec.rb", <<~EO_FEATURE_SPEC
    # frozen_string_literal: true

    require "rails_helper"

    feature "It works, root rails demo page", :js do
      let(:it_works_root) { ItWorksRoot.new }

      scenario "I have rails" do
        When "the root test page is visited" do
          it_works_root.load
        end

        Then "rails version is ~ 7" do
          expect(
            it_works_root.rails_version.text
          ).to match(/7\\.[\\.\\d]+/)
        end

        And "ruby version is ~ 3" do
          expect(
            it_works_root.ruby_version.text
          ).to match(/3\\.[\\.\\d]+/)
        end
      end
    end
  EO_FEATURE_SPEC

  file "spec/support/pages/it_works_root.rb", <<~EO_IT_WORKS_ROOT
    # frozen_string_literal: true

    class ItWorksRoot < SitePrism::Page
      set_url Rails.application.routes.url_helpers.test_root_rails_path

      element :rails_version, "ul li", text: "Rails version"
      element :ruby_version, "ul li", text: "Ruby version"
    end
  EO_IT_WORKS_ROOT

  file "spec/support/capybara.rb", <<~EO_SUPPORT_CAPYBARA
    # frozen_string_literal: true

    require "capybara-inline-screenshot/rspec"

    Capybara.javascript_driver = :selenium_chrome

    Capybara.register_driver :selenium_chrome do |app|
      options = Selenium::WebDriver::Chrome::Options.new
      if ENV.fetch("GITHUB_ACTIONS", nil) == "true"
        options.add_argument("--headless")
        options.add_argument("--disable-gpu")
      end

      args = {browser: :chrome}
      args[:options] = options if options
      Capybara::Selenium::Driver.new(
        app,
        **args
      )
    end

    Capybara::Screenshot.register_driver(:selenium_chrome) do |driver, path|
      driver.browser.save_screenshot(path)
    end
  EO_SUPPORT_CAPYBARA

  run "bin/rspec"

  git add: "."
  git commit: "-a -m '🧪 Testing setup'"

  # rubocop
  file ".rubocop.yml", <<~EO_RUBOCOP_YML
    # based on
    # https://evilmartians.com/chronicles/rubocoping-with-legacy-bring-your-ruby-code-up-to-standard

    require:
      - standard
      - rubocop-capybara
      - rubocop-performance
      - rubocop-rails
      - rubocop-rake
      - rubocop-rspec
      - rubocop-rspec_rails

    # Use the defaults from https://github.com/testdouble/standard.
    inherit_gem:
      standard: config/ruby-3.2.yml

    AllCops:
      TargetRubyVersion: 3.2
      DefaultFormatter: progress
      DisplayCopNames: true
      DisplayStyleGuide: true
      NewCops: enable
      UseCache: true
      CacheRootDirectory: .
      MaxFilesInCache: 10000

    # any rubocop overrides live in here

    Rails/I18nLocaleTexts:
      Enabled: false

    RSpec/Capybara/FeatureMethods:
      EnabledMethods:
        - feature
        - scenario

    RSpec/DescribedClass:
      EnforcedStyle: explicit

    RSpec/ExampleLength:
      CountAsOne:
        - heredoc
        - hash
        - array
      Exclude:
        - spec/features/**/*

    RSpec/MultipleExpectations:
      Exclude:
        - spec/features/**/*
  EO_RUBOCOP_YML

  run "bundle exec rubocop --autocorrect-all"

  git add: "."
  git commit: "-a -m '🤖👮 lint with rubocop'"

  # make
  # note tab indented
  # rubocop:disable Layout/HeredocIndentation
  file "Makefile", <<-EO_MAKE
.DEFAULT_GOAL := usage

# user and repo
USER        = $$(whoami)
CURRENT_DIR = $(notdir $(shell pwd))

# terminal colours
RED     = \033[0;31m
GREEN   = \033[0;32m
YELLOW  = \033[0;33m
BLUE    = \033[0;34m
MAGENTA = \033[0;35m
BOLD    = \033[1m
RESET   = \033[0m

.PHONY: install
install:
	bundle
	yarn

.PHONY: setup
setup: install
	bin/setup

.PHONY: db-migrate
db-migrate:
	RAILS_ENV=test bin/rails db:drop db:create db:migrate

.PHONY: test
test:
	bin/rspec

.PHONY: run
run:
	bin/dev

.PHONY: lint
lint:
	bundle exec rubocop

.PHONY: lint-fix
lint-fix:
	bundle exec rubocop --autocorrect-all

.PHONY: build
build: install setup db-migrate test lint

.PHONY: usage
usage:
	@echo
	@echo "Hi ${GREEN}${USER}!${RESET} Welcome to ${RED}${CURRENT_DIR}${NC}"
	@echo
	@echo "Getting started"
	@echo
	@echo "${YELLOW}make setup${RESET}                 setup"
	@echo
	@echo "${YELLOW}make run${RESET}                   launch app in DEV mode"
	@echo
	@echo "${YELLOW}make lint${RESET}                  lint with rubocop"
	@echo "${YELLOW}make lint-fix${RESET}              lint and autocorrect all"
	@echo
	@echo "${YELLOW}make build${RESET}                 build script"
	@echo
  EO_MAKE
  # rubocop:enable Layout/HeredocIndentation

  run "make"
  run "make build"

  git add: "."
  git commit: "-a -m '🔧 make && make build'"

  # scaffold up a model?
  # rails generate controller Welcome index \
  #   --no-helper \
  #   --test-framework=rspec
  #
  # sed -i .old '/# root/s/# root.*$/root "welcome#index"/' config/routes.rb
  # rm config/routes.rb.old
  #
end
