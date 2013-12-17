class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :father_name
      t.string :mother_name
      t.integer :father_contact_number
      t.integer :mother_contact_number
      t.integer :user_id

      t.timestamps
    end
  end
end
