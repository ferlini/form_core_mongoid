# frozen_string_literal: true

module FormCore
  class ApplicationRecord
    # self.abstract_class = true
    include Mongoid::Document
  end
end
