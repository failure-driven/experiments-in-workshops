class Entry < ApplicationRecord
  # NOTE: use SQL over AREL
  #       eg Entry.published_arel.to_sql
  scope :published, -> { published_sql }
  scope :published_arel, -> {
    entry = arel_table
    Entry.where(
      entry[:generate_ai_text].eq(true)
        .and(entry[:use_generated_text].eq(true))
        .and(entry[:generated_text].not_eq(nil))
    .or(
      entry[:use_generated_text].eq(false)
    )
    )
  }
  scope :published_sql, -> {
    where(
      <<~EO_SQL.squish
        (
          generate_ai_text = 1
          AND use_generated_text = 1
          AND generated_text IS NOT NULL
        ) OR (
          use_generated_text = 0
        )
      EO_SQL
    )
  }
  validates :name, presence: true, allow_blank: false
  validates :text, presence: true, allow_blank: false
end
