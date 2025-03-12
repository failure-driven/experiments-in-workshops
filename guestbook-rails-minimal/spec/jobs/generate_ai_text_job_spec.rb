require "rails_helper"

RSpec.describe GenerateAITextJob do
  let(:entry) do
    Entry.new(
      text: "the text",
      name: "the name",
      generate_job_id: "some id"
    )
  end

  before do
    allow(AITextGenerator).to receive(:generate_text)
      .and_return("the generated text")
  end

  it "calls the AITextGenerator with entry text" do
    GenerateAITextJob.new.perform(entry)
    expect(AITextGenerator).to have_received(:generate_text).with("the text")
  end

  it "updates the generated text and job id" do
    GenerateAITextJob.new.perform(entry)
    expect(entry).to have_attributes(
      generated_text: "the generated text",
      generate_job_id: nil
    )
  end
end
