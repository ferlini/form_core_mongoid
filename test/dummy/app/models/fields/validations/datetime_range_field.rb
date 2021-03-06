# frozen_string_literal: true

module Fields::Validations
  class DatetimeRangeField < FieldOptions
    prepend Concerns::Fields::Validations::Presence
  end
end
