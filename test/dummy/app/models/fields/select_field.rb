# frozen_string_literal: true

module Fields
  class SelectField < Field
    field :validations, type: Validations::SelectField
    field :options, type: Options::SelectField

    def stored_type
      :string
    end

    def attach_choices?
      true
    end

    protected

    def interpret_extra_to(model, accessibility, overrides = {})
      super
      return if accessibility != :read_and_write || !options.strict_select
      model.validates name, inclusion: {in: choices.map(&:label)}, allow_blank: true
    end
  end
end
