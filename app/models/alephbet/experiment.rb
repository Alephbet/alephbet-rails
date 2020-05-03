# rubocop:disable Layout/LineLength
# == Schema Information
#
# Table name: alephbet_experiments
#
#  id         :bigint           not null, primary key
#  counter    :integer          default(0), not null
#  event      :string           not null
#  experiment :string           not null
#  namespace  :string           default("alephbet"), not null
#  variant    :string           not null
#
# Indexes
#
#  by_experiments  (namespace,experiment,variant,event) UNIQUE
#
# rubocop:enable Layout/LineLength

module Alephbet
  class Experiment < ApplicationRecord
  end
end
