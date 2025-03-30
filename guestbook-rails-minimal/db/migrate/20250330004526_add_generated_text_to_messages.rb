class AddGeneratedTextToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :generated_text, :string, null: true
  end
end
