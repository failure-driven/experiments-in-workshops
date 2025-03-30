class CreateGuestbookEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :guestbook_entries do |t|
      t.text :body
      t.string :name

      t.timestamps
    end
  end
end
