Alephbet.setup do |config|
  config.api_key = ENV["ALEPHBET_API_KEY"] || SecureRandom.uuid
  config.cors_allow_origin = "*"
  config.cors_allow_headers = "*"
end
