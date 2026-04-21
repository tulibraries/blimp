require 'test_helper'
require "rack/test"

module Blimp
  class UploadsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @upload = blimp_uploads(:one)
    end

    test "should get index" do
      get uploads_url
      assert_response :success
    end

    test "should get new" do
      get new_upload_url
      assert_response :success
    end

    test "should create upload" do
      HarvestCSV.stub(:make_map, nil) do
        HarvestCSV.stub(:harvest, nil) do
          assert_no_difference('Upload.count') do
            post uploads_url, params: { upload: { datafile: csv_upload, id_field: "game_id", map_filename: Rails.root.join("config", "solr_map.yml").to_s } }
          end
        end
      end

      assert_redirected_to "/"
    end

    test "should show upload" do
      get upload_url(@upload)
      assert_response :success
    end

    test "should get edit" do
      get edit_upload_url(@upload)
      assert_response :success
    end

    test "should update upload" do
      HarvestCSV.stub(:make_map, nil) do
        HarvestCSV.stub(:harvest, nil) do
          patch upload_url(@upload), params: { upload: { datafile: csv_upload, id_field: "game_id", map_filename: Rails.root.join("config", "solr_map.yml").to_s } }
        end
      end

      assert_redirected_to upload_url(@upload)
    end

    test "should destroy upload" do
      assert_difference('Upload.count', -1) do
        delete upload_url(@upload)
      end

      assert_redirected_to uploads_url
    end

    private

    def csv_upload
      Rack::Test::UploadedFile.new(
        File.expand_path("../../fixtures/files/sample.csv", __dir__),
        "text/csv"
      )
    end
  end
end
