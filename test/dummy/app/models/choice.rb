# frozen_string_literal: true

class Choice < ApplicationRecord

  field :label, type: String

  belongs_to :form_field, class_name: 'Field'

  has_many :entry_items, dependent: :delete_all

  validates :label,
            presence: true

  def destroyable?
    entry_items.empty?
  end
end
