class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.references :ticket, index: true
      t.references :user, index: true
    end
    
    add_column :tickets, :state_id, :integer, index: true
    add_column :comments, :state_id, :integer
  end
end
