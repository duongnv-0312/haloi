class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.belongs_to :product, index: true
      t.attachment :pictures, :image
      t.string :pictures, :description

      t.timestamps
    end
  end
end
