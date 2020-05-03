include Rails.application.routes.url_helpers

namespace :alephbet do
  desc "view experiment results"
  task :dashboard => :environment do
    base_url = root_url.chomp("/")
    experiments_path = Alephbet::Engine.routes.url_helpers.alephbet_experiments_path
    experiments_url = "#{base_url}#{experiments_path}"
    puts "Open your browser and go to: " \
         "https://codepen.io/anon/pen/LOGGZj/" \
         "?experiment_url=#{experiments_url}&" \
         "api_key=#{Alephbet.api_key}&" \
         "namespace=alephbet"

    return if base_url =~ /https/

    puts "NOTE: #{experiments_url} without SSL. The dashboard works only with https"
  end
end
