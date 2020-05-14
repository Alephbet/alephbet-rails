require "alephbet/engine"

module Alephbet
  class << self
    attr_accessor :api_key, :enable_cors, :cors_allow_origin, :cors_allow_headers

    def setup
      # fallback api_key if none specified
      self.api_key = SecureRandom.uuid
      self.enable_cors = true
      self.cors_allow_origin = "*"
      self.cors_allow_headers = "*"
      yield(self) if block_given?
    end
  end
end
