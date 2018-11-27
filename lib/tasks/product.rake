require "csv"

namespace :product do
  desc "Import products from csv file"

  task import: :environment do
    Product.destroy_all
    errors = []
    count = 0
    CSV.foreach("#{Rails.root}/db/masters/product.csv", headers: true).with_index(1) do |row, index|
      product = Product.new row.to_h
      if product.save
        count += 1
      else
        errors << "Error on row: #{index}, #{product.errors.messages}"
      end
      Rails.logger.error errors.to_s if errors.present?
      puts "Import done"
      puts "#{count} record import successfully."\
        "#{errors.count} errors. Check log"
    end
  end
end
