# frozen_string_literal: true

module Fields::Options
  class SelectField < FieldOptions
    attribute :strict_select, :boolean, default: true
  end
end
