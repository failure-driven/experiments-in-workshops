# frozen_string_literal: true

module TextGenerator
  class OllamaAIGenerator < AITextGenerator
    attr_accessor :client

    def initialize
      @client ||= OpenAI::Client.new({uri_base: "http://localhost:11434"})
      super
    end

    def generate_text(message)
      # NOTE: More information on how to tune the ruby-openai library
      # https://github.com/alexrudall/ruby-openai
      response = client.chat(
        parameters: {
          model: "mistral", # Required.
          messages: [{
            role: "user",
            content: <<~EO_CONTENT.chomp
              You are an editor for comments on review site for a software
              coding workshop. You will clean up any punctuation, improve the
              structure and make the comment more complete. You will return
              the output in JSON as
              { original_comment: #{message.inspect}, improved_comment: ""}
            EO_CONTENT
          }],
          temperature: 0.7
        }
      )

      logger.info(response) if ENV.fetch("DEBUG", nil)
      content = response.dig("choices", 0, "message", "content")
      begin
        json_content = JSON.parse(content, symbolize_names: true)
        json_content.dig(:improved_comment)
      rescue TypeError, JSON::ParserError => e
        logger.error("failed to parse json #{e} for\n#{content}")
      end
    end
  end
end
