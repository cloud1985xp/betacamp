class ForeignProvider < Provider
  def full_address
    [street, city, state, zip_code, country].join(', ')
  end
end