module Alephbet
  class TrackingController < ApplicationController
    PARAMS = %i[experiment variant event namespace uuid].freeze

    def event
      respond_to do |format|
        format.json {
          begin
            Alephbet::Tracking.create(permitted_tracking_params)
            Alephbet::Experiment.increment_counter(:counter, experiment_id)
          rescue ActiveRecord::RecordNotUnique
            # ignoring duplicate requests
          end
          render :json => {}, :status => :ok
        }
      end
    end

    private

    def experiment_id
      Alephbet::Experiment.find_or_create_by(permitted_experiment_params).id
    end

    def permitted_tracking_params
      params.permit(PARAMS.without(:variant, :event))
    end

    def permitted_experiment_params
      params.permit(PARAMS.without(:uuid))
    end
  end
end
