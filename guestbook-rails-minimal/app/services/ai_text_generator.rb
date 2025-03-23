# frozen_string_literal: true

class AITextGenerator
  class << self
    attr_writer :backend

    delegate :generate_text, to: :backend

    def backend
      @backend ||= get_valid_generator
    end

    private

    def get_valid_generator
      env_var_generator = ENV.fetch("TEXT_GENERATOR", NoopGenerator.name.demodulize)
      generator = VALID_GENERATORS[env_var_generator]
      raise "invalid generator provided #{env_var_generator}" unless generator
      generator.new
    end
  end

  # delegate :logger, to: Rails.logger
  attr_reader :logger

  def initialize
    @logger ||= Rails.logger
  end

  class BedrockAIGenerator
    # TODO
    def generate_text(input_text)
      raise NotImplementedError, "generate_text not implemented for BedrockAIGenerator"
    end
  end

  class NoopGenerator
    def generate_text(input_text)
      "AI GENERATED #{input_text}"
    end
  end

  VALID_GENERATORS = {
    TextGenerator::OllamaAIGenerator.name.demodulize => TextGenerator::OllamaAIGenerator,
    TextGenerator::OpenAIGenerator.name.demodulize => TextGenerator::OpenAIGenerator,
    BedrockAIGenerator.name.demodulize => BedrockAIGenerator,
    NoopGenerator.name.demodulize => NoopGenerator
  }.freeze
end
