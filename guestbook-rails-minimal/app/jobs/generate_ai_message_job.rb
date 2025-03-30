class GenerateAIMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    generated_text = AITextGenerator.generate_text(message.text)
    message.update!(generated_text: generated_text)
  end
end
