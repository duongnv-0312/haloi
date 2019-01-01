class Product < ApplicationRecord
  # belongs_to :category
  has_many :pictures, dependent: :destroy

  # has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  class << self
    def ransackable_attributes(auth_object = nil)
      %w(name)
    end
  end
end
