# frozen_string_literal: true

module TextGenerator
  class OpenAIGenerator < AITextGenerator
    def initialize
      OpenAI.configure do |config|
        config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
        config.log_errors = true
      end
      @client = OpenAI::Client.new({})
      super
    end

    def generate_text(input_text)
      # NOTE: More information on how to tune the ruby-openai library
      # https://github.com/alexrudall/ruby-openai
      response = @client.chat(
        parameters: {
          model: "gpt-4o", # Required.
          messages: [{
            role: "user",
            content: <<~EO_CONTENT.chomp
              You are an editor for comments on review site for a software
              coding workshop. You will clean up any punctuation, improve the
              structure and make the comment more complete. You will return
              the output in JSON as
              { original_comment: #{input_text.inspect}, improved_comment: ""}
            EO_CONTENT
          }],
          temperature: 0.7,
          tools: [
            {
              type: "function",
              function: {
                name: "get_generated_text",
                description: "get improved generated text",
                # Format: https://json-schema.org/understanding-json-schema
                parameters: {
                  type: :object,
                  properties: {
                    improved_comment: {
                      type: :string,
                      description: "improved comment"
                    }
                  },
                  required: ["imporoved_comment"]
                }
              }
            }
          ],
          tool_choice: "required"  # Optional, defaults to "auto"
        }
      )
      logger.info response if ENV.fetch("DEBUG", nil)
      response.dig("choices", 0, "message", "tool_calls").map do |tool_call|
        JSON.parse(
          tool_call.dig("function", "arguments"),
          symbolize_names: true
        )[:improved_comment]
      end.first # return first best
    end
  end
end
