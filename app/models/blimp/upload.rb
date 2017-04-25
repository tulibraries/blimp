module Blimp
  class Upload < ApplicationRecord
    validates_presence_of :datafile
    mount_uploader :datafile , DatafileUploader
  end
end
