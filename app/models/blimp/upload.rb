module Blimp
  class Upload < ApplicationRecord
    mount_uploader :datafile , DatafileUploader
  end
end
