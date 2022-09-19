class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.references :company, null: false, foreign_key: true
      t.integer :nopage
      t.integer :numpages
      t.string :extension

      t.timestamps
    end
  end
end
