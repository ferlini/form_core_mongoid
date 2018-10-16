# frozen_string_literal: true

module Fields
  class ResourceSelectField < Field
    field :options, type: Options::ResourceSelectField
    field :validations, type: Validations::ResourceSelectField

    def stored_type
      :string
    end

    def data_source
      options.data_source
    end

    def collection
      data_source.scoped_records.map(&data_source.text_method)
    end

    protected

    def interpret_extra_to(model, accessibility, overrides = {})
      super
      return if accessibility != :read_and_write || !options.strict_select
      model.validates name, inclusion: {in: collection}, allow_blank: true
    end
  end
end
