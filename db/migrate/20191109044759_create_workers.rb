class CreateWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :workers do |t|
      t.string :name
      t.integer :age
      t.integer :blog_id

      t.timestamps
    end
  end
end
