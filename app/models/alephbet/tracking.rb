# rubocop:disable Layout/LineLength
# == Schema Information
#
# Table name: alephbet_tracking
#
#  id         :bigint           not null, primary key
#  event      :string           not null
#  experiment :string           not null
#  namespace  :string           default("alephbet"), not null
#  uuid       :string           not null
#  variant    :string           not null
#
# Indexes
#
#  index_alephbet_tracking_on_uuid  (uuid) UNIQUE
#
# rubocop:enable Layout/LineLength
module Alephbet
  class Tracking < ApplicationRecord
    self.table_name = "alephbet_tracking"
  end
end
