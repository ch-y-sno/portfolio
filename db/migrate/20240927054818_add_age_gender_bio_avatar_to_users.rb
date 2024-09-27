class AddAgeGenderBioAvatarToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :integer
    add_column :users, :bio, :text
    add_column :users, :avatar, :string
  end
end
