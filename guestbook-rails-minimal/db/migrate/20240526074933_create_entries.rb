class CreateEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.string :text
      t.string :name
      t.datetime :date

      t.timestamps
    end
  end
end
