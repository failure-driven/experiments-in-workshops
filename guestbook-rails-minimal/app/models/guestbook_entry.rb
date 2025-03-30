class GuestbookEntry < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false
end
