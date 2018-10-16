# frozen_string_literal: true

class Section < ApplicationRecord

  field :title, type: String
  field :headless, type: Boolean

  belongs_to :form, touch: true

  has_many :form_fields, class_name: 'Field', dependent: :nullify
  # has_many :fields, -> { order(position: :asc) }, dependent: :nullify

  # acts_as_list scope: [:form_id]

  validates :title,
            presence: true
end
