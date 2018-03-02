class CreateTableUser < ActiveRecord::Migration[5.1]
  def change
    create_table :table_users do |t|
      t.string :nick_name
      t.string :first_name, limit: 64
      t.string :last_name, limit: 64
      t.string :phone_number, limit: 16
      t.string :email
      t.string :password
    end
  end
end
