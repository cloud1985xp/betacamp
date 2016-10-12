require 'pay2go'
pay2go_config = Rails.application.config_for(:pay2go)

Pay2go.setup do |config|
  config.merchant_id = pay2go_config["merchant_id"]
  config.hash_key = pay2go_config["hash_key"]
  config.hash_iv = pay2go_config["hash_iv"]
  config.url = pay2go_config["url"]
  config.notify_url = pay2go_config["notify_url"]
end