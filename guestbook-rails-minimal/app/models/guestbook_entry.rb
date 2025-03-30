class GuestbookEntry < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false

  has_one :generated_guestbook_entry, dependent: :destroy
end
