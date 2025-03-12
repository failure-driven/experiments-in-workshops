require "rails_helper"

RSpec.describe AITextGenerator do
  it "generates text" do
    expect(AITextGenerator.generate_text("some text")).to eq "AI GENERATED some text"
  end

  it "defaults to NoopTextGeneratorgenerates text" do
    expect(AITextGenerator.backend.class).to eq AITextGenerator::NoopGenerator
  end
end
