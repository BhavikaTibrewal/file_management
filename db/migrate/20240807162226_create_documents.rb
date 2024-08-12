class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file_name
      t.bigint :file_size
      t.string :path
      t.boolean :sharing
      t.datetime :uploaded_at
      t.string :uuid

      t.timestamps
    end
  end
end
