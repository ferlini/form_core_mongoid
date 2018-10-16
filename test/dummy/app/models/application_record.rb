# frozen_string_literal: true

class ApplicationRecord
  # self.abstract_class = true

  include Mongoid::Document
  include Mongoid::Timestamps
  include EnumAttributeLocalizable
end
