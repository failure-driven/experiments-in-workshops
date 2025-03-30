class CreateGeneratedGuestbookEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :generated_guestbook_entries do |t|
      t.text :body
      t.references :guestbook_entry, index: {unique: true}, null: false, foreign_key: true

      t.timestamps
    end
  end
end
