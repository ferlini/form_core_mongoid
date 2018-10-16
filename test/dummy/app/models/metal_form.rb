# frozen_string_literal: true

class MetalForm < ApplicationRecord
  include FormCore::Concerns::Models::Form

  # field :type, type: String
  field :title, type: String
  field :description, type: String

  has_many :form_fields, class_name: 'Field'
end
