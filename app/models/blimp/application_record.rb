# frozen_string_literal: true

module Blimp
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
