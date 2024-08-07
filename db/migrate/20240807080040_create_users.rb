class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :user_name, index: {unique: true}, :limit => 15, :null => false
      t.string :full_name, :null => false
      t.string :email, :null => false
      t.string :password, :null => false
      t.timestamps
    end
  end
end
