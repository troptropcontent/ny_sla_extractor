class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.integer :month
      t.integer :year
      t.integer :kind
      t.integer :source

      t.timestamps
    end
  end
end
