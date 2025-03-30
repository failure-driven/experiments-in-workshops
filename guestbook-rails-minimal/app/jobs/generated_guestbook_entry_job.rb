class GeneratedGuestbookEntryJob < ApplicationJob
  queue_as :default

  def perform(generated_guestbook_entry)
    generated_text = AITextGenerator.generate_text(generated_guestbook_entry.guestbook_entry.body)
    generated_guestbook_entry.update!(body: generated_text)
  end
end
