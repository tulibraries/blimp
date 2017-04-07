module Blimp
  class Upload < ApplicationRecord
    valdates_presence_of :datafile
    mount_uploader :datafile , DatafileUploader
  end
end
