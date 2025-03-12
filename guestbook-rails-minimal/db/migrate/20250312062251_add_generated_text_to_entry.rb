class AddGeneratedTextToEntry < ActiveRecord::Migration[7.1]
  def change
    add_column :entries, :generate_ai_text, :boolean, default: false, null: false
    add_column :entries, :generated_text, :string, null: true
    add_column :entries, :use_generated_text, :boolean, default: false, null: false
  end
end
