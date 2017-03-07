class CreateBlimpUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :blimp_uploads do |t|
      t.string :map_filename
      t.string :id_field
      t.string :datafile

      t.timestamps
    end
  end
end
