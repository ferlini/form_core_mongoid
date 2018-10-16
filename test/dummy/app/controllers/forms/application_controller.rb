# frozen_string_literal: true

class Forms::ApplicationController < ApplicationController
  layout "forms"

  before_action :set_form

  protected

  # Use callbacks to share common setup or constraints between actions.
  def set_form
    @form = Form.find(params[:form_id])
  end

  def set_form_with_eager_load_fields_and_sections
    @form = Form.includes(:sections, form_fields: [:choices]).find(params[:form_id])

    # grouped_fields = @form.form_fields.group_by(&:section_id)
    # @form.sections.each do |section|
    #   association = section.form_fields.instance_variable_get(:@association)
    #   association.target.concat grouped_fields.fetch(section.id, []).sort_by(&:position)
    #   association.loaded!
    # end
  end
end
