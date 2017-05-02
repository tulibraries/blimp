require 'tempfile'
require 'harvest_csv'
require_dependency "blimp/application_controller"

module Blimp
  class UploadsController < ApplicationController
    before_action :set_upload, only: [:show, :edit, :upload, :delete]

    # GET /uploads
    def index
      @uploads = Upload.all
    end

    # GET /uploads/1
    def show
    end

    # GET /uploads/new
    def new
      @upload = Upload.new
      @upload.map_filename = File.join(Rails.root, 'config', 'solr_map.yml')
    end

    # GET /uploads/1/edit
    def edit
    end

    # POST /uploads
    def create
      # Generate a SOLR map file
      map_filename = upload_params['map_filename']
      csv_filename = upload_params["datafile"].tempfile.path
      id_field = upload_params["id_field"]
      HarvestCSV.make_map(csv_filename,
                          map_filename,
                          id_field) unless File.exist?(map_filename)
      # Harvest the data
      HarvestCSV.harvest(csv_filename,
                         map_filename,
                         solr_endpoint = 'http://localhost:8983/solr/blacklight-core')

      #FileUtils.rm(@upload.datafile.current_path) if FileTest.exist?(@upload.datafile.current_path)
      redirect_to "/", notice: 'Upload was successfully created.'

    end

    # PATCH/PUT /uploads/1
    def update
      if @upload.update(upload_params)
        redirect_to @upload, notice: 'Upload was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /uploads/1
    def destroy
      FileUtils.rm(@upload.datafile.current_path) if FileTest.exist?(@upload.datafile.current_path)
      FileUtils.rm(@upload.map_filename) if FileTest.exist?(@upload.map_filename)
      @upload.destroy
      redirect_to uploads_url, notice: 'Upload was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_upload
        @upload = Upload.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def upload_params
        params.require(:upload).permit(:map_filename, :id_field, :datafile)
      end
  end
end
