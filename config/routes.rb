Alephbet::Engine.routes.draw do
  get "experiments" => "management#experiments", :as => "alephbet_experiments"
  match "experiments" => "management#cors_preflight_check", :via => :options

  get "event" => "tracking#event"
end
