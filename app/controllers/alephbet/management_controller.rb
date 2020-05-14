module Alephbet
  class ManagementController < ApplicationController
    PARAMS = %i[experiment variant event namespace].freeze

    # acts a browser-friendly API endpoint
    skip_before_action :verify_authenticity_token
    before_action :check_api_key, :except => :cors_preflight_check

    def experiments
      namespace = permitted_params[:namespace] || "alephbet"
      @scope = Alephbet::Experiment.where(:namespace => namespace)
      refine_scope if permitted_params[:scope].present?

      respond_to do |format|
        format.json {
          render :json => results, :status => :ok
        }
      end
    end

    def cors_preflight_check
      head :ok
    end

    private

    def results
      unique_experiments.map { |experiment| experiment_data(experiment) }
    end

    def experiment_data(experiment)
      {
        :experiment => experiment,
        :goals => unique_goals.map { |goal| goal_data(experiment, goal) }
      }
    end

    def goal_data(experiment, goal)
      {
        :goal => goal,
        :results => variants.map { |variant|
          {
            :label => variant,
            :trials => counter_for(experiment, "participate", variant),
            :successes => counter_for(experiment, goal, variant)
          }
        }
      }
    end

    def counter_for(experiment, event, variant)
      @scope.find { |item|
        item.experiment == experiment &&
        item.event == event &&
        item.variant == variant
      }.try(:counter).to_i
    end

    def unique_experiments
      @scope.map(&:experiment).uniq
    end

    def variants
      @scope.map(&:variant).uniq
    end

    def unique_goals
      @scope.reject { |item| item.event == "participate" }.map(&:event).uniq
    end

    def check_api_key
      api_header = request.headers["X-Api-Key"]
      valid_key = ActiveSupport::SecurityUtils.secure_compare(Alephbet.api_key, api_header)
      head :forbidden unless valid_key
    end

    def refine_scope
      @scope = @scope.where(:experiment => permitted_params[:scope].split(","))
    end

    def permitted_params
      params.permit(PARAMS)
    end
  end
end
