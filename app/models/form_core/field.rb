# frozen_string_literal: true

module FormCore
  class Field < ApplicationRecord
    include FormCore::Concerns::Models::Field

    embeds_many :validations, class_name: FieldOptions

    field :name, type: String
    field :accessibility, type: Integer
    field :validations, type: Hash
    field :options, type: Hash

    embedded_in :form
  end
end
