# frozen_string_literal: true

RSpec.describe AITextGenerator do
  it "generates text" do
    expect(AITextGenerator.generate_text("some text")).to eq "AI GENERATED some text"
  end

  it "defaults to NoopTextGeneratorgenerates text" do
    expect(AITextGenerator.backend.class).to eq AITextGenerator::NoopGenerator
  end

  it "allows a valid TEXT_GENERATOR to be set by environment variable" do
    AITextGenerator.remove_instance_variable(:@backend)
    allow(ENV).to receive(:fetch).and_return("OllamaAIGenerator")
    expect(AITextGenerator.backend.class).to eq TextGenerator::OllamaAIGenerator
  end

  it "complains bitterly for invalid TEXT_GENERATOR" do
    AITextGenerator.remove_instance_variable(:@backend)
    allow(ENV).to receive(:fetch).and_return("NotAGenerator")
    expect {
      AITextGenerator.backend
    }.to raise_error RuntimeError, "invalid generator provided NotAGenerator"
  end
end
