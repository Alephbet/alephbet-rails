module Alephbet
  class ApplicationController < ActionController::Base
    protect_from_forgery :with => :exception
    before_action :cors_headers, :if => -> { Alephbet.enable_cors }

    private

    def cors_headers
      response.headers["Access-Control-Allow-Origin"] = Alephbet.cors_allow_origin
      response.headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
      response.headers["Access-Control-Allow-Headers"] = Alephbet.cors_allow_headers
      response.headers["Access-Control-Max-Age"] = "1728000"
    end
  end
end
