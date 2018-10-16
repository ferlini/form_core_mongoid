# frozen_string_literal: true

module Fields
  class TextField < Field
    field :validations, type: Validations::TextField
    field :options, type: Fields::Options::TextField

    def stored_type
      :string
    end
  end
end
