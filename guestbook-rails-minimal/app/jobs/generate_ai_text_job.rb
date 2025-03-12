class GenerateAITextJob < ApplicationJob
  queue_as :default

  def perform(entry)
    generated_text = AITextGenerator.generate_text(entry.text)
    entry.update!(generated_text:, generate_job_id: nil)
  end
end
