namespace :dev do
  task :friendly_id => :environment do
    Product.find_each do |p|
      str = p.name.downcase.to_param.gsub(' ','-')
      p.update_column(:friendly_id, str)
    end
  end
end