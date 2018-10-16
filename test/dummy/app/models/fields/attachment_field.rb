# frozen_string_literal: true

module Fields
  class AttachmentField < Field
    # serialize :validations, Validations::AttachmentField
    # serialize :options, Options::AttachmentField

    def stored_type
      :integer
    end

    def interpret_to(model, overrides: {})
      check_model_validity!(model)

      accessibility = overrides.fetch(:accessibility, self.accessibility)
      return model if accessibility == :hidden

      model.attribute name, stored_type
      model.has_one_attached name
      if accessibility == :readonly
        model.attr_readonly name
      end

      interpret_validations_to model, accessibility, overrides
      interpret_extra_to model, accessibility, overrides

      model
    end
  end
end
