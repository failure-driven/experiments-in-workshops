class Entry < ApplicationRecord
  validates :text, presence: true, allow_blank: false
end
