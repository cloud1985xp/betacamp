class LocalProvider < Provider
  def full_address
    [country, city, street, zip_code].join
  end
end