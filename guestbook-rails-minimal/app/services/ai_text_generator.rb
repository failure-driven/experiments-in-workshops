class AITextGenerator
  class << self
    attr_writer :backend

    delegate :generate_text, to: :backend

    def backend
      @backend ||= NoopGenerator.new
    end
  end

  class OpenAIGenerator
    # TODO
    def generate_text(input_text)
      raise NotImplementedError, "generate_text not implemented for OpenAIGenerator"
    end
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
end
