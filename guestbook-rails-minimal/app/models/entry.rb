class Entry < ApplicationRecord
  scope :published, -> {
    entry = arel_table
    Entry.where(
      entry[:generate_ai_text].eq(true).and(entry[:generated_text].not_eq(nil))
    .or(
      entry[:generate_ai_text].eq(false)
    )
    )
  }
  validates :name, presence: true, allow_blank: false
  validates :text, presence: true, allow_blank: false
end
