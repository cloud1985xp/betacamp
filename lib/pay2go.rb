class Pay2go
  mattr_accessor :merchant_id
  mattr_accessor :hash_key
  mattr_accessor :hash_iv
  mattr_accessor :url
  mattr_accessor :notify_url

  def initialize(params)
    data = params.stringify_keys
    @params = data
  end

  def self.setup
    yield(self)
  end

  def make_check_value
    raw = @params.slice("Amt", "MerchantID", "MerchantOrderNo", "TimeStamp", "Version").sort.map!{|ary| "#{ary.first}=#{ary.last}"}.join('&')
    str = "HashKey=#{hash_key}&#{raw}&HashIV=#{hash_iv}"
    Digest::SHA256.hexdigest(str).upcase
  end

  def make_check_code
    raw = @params.slice("Amt", "MerchantID", "MerchantOrderNo", "TradeNo").sort.map!{|ary| "#{ary.first}=#{ary.last}"}.join('&')
    str = "HashIV=#{hash_iv}&#{raw}&HashKey=#{hash_key}"

    Digest::SHA256.hexdigest(str).upcase
  end

  def check_mac
    ( make_check_code == @params["CheckCode"] ) ||
    ( make_check_value == @params["CheckValue"] )
  end
end
