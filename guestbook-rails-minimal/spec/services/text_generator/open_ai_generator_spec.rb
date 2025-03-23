# frozen_string_literal: true

require "rails_helper"

RSpec.describe TextGenerator::OpenAIGenerator do
  before do
    allow(ENV).to receive(:fetch)
    allow(OpenAI::Client).to receive(:new).and_return(mock_chat)
    allow(OpenAI).to receive(:configure).and_yield(mock_openai_config)
    allow(mock_openai_config).to receive(:access_token=)
    allow(mock_openai_config).to receive(:log_errors=)
  end

  let(:mock_logger) { instance_double(Rails.logger.class, error: nil, info: nil) }
  let(:chat_response) {
    {
      choices: [
        message: {
          tool_calls: [{
            function: {
              arguments: {
                improved_comment: "the IMPROVED text"
              }.to_json
            }
          }]
        }
      ]
    }.with_indifferent_access
  }
  let(:mock_chat) { instance_double(OpenAI::Client, chat: chat_response) }
  let(:mock_openai_config) { instance_double(OpenAI::Configuration) }

  it "configures OpenAI with the access token" do
    allow(ENV).to receive(:fetch).with("OPENAI_ACCESS_TOKEN").and_return("secret token")
    TextGenerator::OpenAIGenerator.new
    expect(mock_openai_config).to have_received(:access_token=).with("secret token")
  end

  it "calls chat on the client including the input text" do
    generator = TextGenerator::OpenAIGenerator.new
    generator.generate_text("the input text")
    expect(mock_chat).to have_received(:chat).with(
      hash_including(
        parameters: hash_including(
          model: "gpt-4o",
          messages: [
            hash_including(
              content: match("the input text")
            )
          ]
        )
      )
    )
  end

  it "logs in debug mode" do
    allow(ENV).to receive(:fetch).with("DEBUG", nil).and_return(true)
    generator = TextGenerator::OpenAIGenerator.new
    generator.instance_variable_set(:@logger, mock_logger)
    generator.generate_text("some input")
    expect(mock_logger).to have_received(:info).with(
      {
        "choices" => [
          {
            "message" => {
              "tool_calls" => [{
                "function" => {"arguments" => "{\"improved_comment\":\"the IMPROVED text\"}"}
              }]
            }
          }
        ]
      }
    )
  end

  it "parses valid content" do
    generator = TextGenerator::OpenAIGenerator.new
    expect(generator.generate_text("the input text")).to eq("the IMPROVED text")
  end
end
