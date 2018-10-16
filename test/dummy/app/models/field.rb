# frozen_string_literal: true

class Field < ApplicationRecord
  include Mongoid::Enum
  include FormCore::Concerns::Models::Field

  field :name, type: String
  field :accessibility, type: Integer
  field :validations, type: Hash
  field :options, type: Hash
  field :label, type: String
  field :hint, type: String
  field :position, type: Integer

  belongs_to :form, class_name: "MetalForm"

  belongs_to :section

  has_many :choices, dependent: :destroy, autosave: true
  # has_many :choices, -> { order(position: :asc) }, dependent: :destroy, autosave: true

  # acts_as_list scope: [:section_id]

  validates :label,
            presence: true
  validates :_type,
            inclusion: {
              in: ->(_) { Field.descendants.map(&:to_s) }
            },
            allow_blank: false

  def self.type_key
    model_name.name.split("::").last.underscore
  end

  def type_key
    self.class.type_key
  end

  def options_configurable?
    options.is_a?(FieldOptions) && options.attributes.any?
  end

  def validations_configurable?
    validations.is_a?(FieldOptions) && validations.attributes.any?
  end

  def attach_choices?
    false
  end

  protected

  def interpret_validations_to(model, accessibility, overrides = {})
    return unless accessibility == :read_and_write

    validations_overrides = overrides.fetch(:validations) { {} }
    validations =
      if validations_overrides.any?
        self.validations.dup.update(validations_overrides)
      else
        self.validations
      end

    validations.interpret_to(model, name, accessibility)
  end

  def interpret_extra_to(model, accessibility, overrides = {})
    options_overrides = overrides.fetch(:options) { {} }
    options =
      if options_overrides.any?
        self.options.dup.update(options_overrides)
      else
        self.options
      end

    options.interpret_to(model, name, accessibility)
  end
end

require_dependency "fields"
