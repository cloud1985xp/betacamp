class ExportMailer < ApplicationMailer
  def product(mailto, file_path)
    attachments["product_export_file.csv"] = File.read(file_path)
    mail(:to => mailto, :subject => 'Export Product File')
  end
end