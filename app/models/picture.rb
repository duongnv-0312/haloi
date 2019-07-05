class Picture < ApplicationRecord
  belongs_to :product

  has_attached_file :image,
    path: ":rails_root/public/images/:id/:filename",
    url: "/images/:id/:filename",
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png"]
end
