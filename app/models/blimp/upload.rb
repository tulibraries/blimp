# frozen_string_literal: true

module Blimp
  class Upload < ApplicationRecord
    validates :datafile, presence: true
    mount_uploader :datafile , DatafileUploader
  end
end
