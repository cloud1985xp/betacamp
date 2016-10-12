class ExportProductJob < ApplicationJob
  queue_as :default

  def perform(email)
    file = Tempfile.new(Time.now.to_i.to_s)
    file.write("Name,Category,Price\n")
    Product.find_each do |product|
      data = [
        product.name,
        product.category.name,
        product.price
      ]
      file.write("#{data.join(',')}\n")
    end
    file.close
    ExportMailer.product(email, file.path).deliver!
    file.unlink
  end
end