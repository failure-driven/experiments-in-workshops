# frozen_string_literal: true

RSpec.describe TextGenerator::OllamaAIGenerator do
  before do
    allow(OpenAI::Client).to receive(:new).and_return(mock_chat)
  end

  let(:mock_logger) { instance_double(Rails.logger.class, error: nil, info: nil) }
  let(:chat_response) {
    {
      choices: [
        message: {
          content: {
            original_comment: "the ORIGINAL text",
            improved_comment: "the IMPROVED text"
          }.to_json
        }
      ]
    }.with_indifferent_access
  }
  let(:mock_chat) { instance_double(OpenAI::Client, chat: chat_response) }

  it "points the client at localhost 11434" do
    TextGenerator::OllamaAIGenerator.new
    expect(OpenAI::Client).to have_received(:new).with(uri_base: "http://localhost:11434")
  end

  it "calls chat on the client including the input text" do
    generator = TextGenerator::OllamaAIGenerator.new
    generator.generate_text("the input text")
    expect(mock_chat).to have_received(:chat).with(
      hash_including(
        parameters: hash_including(
          model: "mistral",
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
    generator = TextGenerator::OllamaAIGenerator.new
    generator.instance_variable_set(:@logger, mock_logger)
    generator.generate_text("some input")
    expect(mock_logger).to have_received(:info).with(
      {
        "choices" => [
          {
            "message" => {
              "content" => "{\"original_comment\":\"the ORIGINAL text\"," \
                "\"improved_comment\":\"the IMPROVED text\"}"
            }
          }
        ]
      }
    )
  end

  it "parses valid content" do
    generator = TextGenerator::OllamaAIGenerator.new
    expect(generator.generate_text("the input text")).to eq("the IMPROVED text")
  end

  context "with invalid JSON in the content" do
    let(:chat_response) {
      {
        choices: [
          message: {
            content: "{\"the_content\":\"not valid"
          }
        ]
      }.with_indifferent_access
    }

    it "logs the error and JSON" do
      generator = TextGenerator::OllamaAIGenerator.new
      generator.instance_variable_set(:@logger, mock_logger)
      generator.generate_text("the input text")
      expect(mock_logger).to have_received(:error).with(
        <<~EO_ERROR.chomp
          failed to parse json unexpected token at '{"the_content":"not valid' for
          {"the_content":"not valid
        EO_ERROR
      )
    end
  end
end
