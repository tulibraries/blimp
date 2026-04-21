require "test_helper"
require "minitest/mock"

class HarvestCSVTest < ActiveSupport::TestCase
  test "make_map writes default mappings for csv headers" do
    with_tempfile("game_id,title\n1,Example\n") do |csv|
      map = Tempfile.new(["solr_map", ".yml"])

      HarvestCSV.make_map(csv.path, map.path, "game_id")
      parsed = YAML.safe_load(File.read(map.path), permitted_classes: [], aliases: false)

      assert_equal ["id", "game_id_display", "game_id_facet"], parsed["game_id"]
      assert_equal ["title_display", "title_facet"], parsed["title"]
    ensure
      map.close!
    end
  end

  test "harvest sends mapped documents to solr" do
    with_tempfile("game_id,title,notes\n1,Example,\n") do |csv|
      map = Tempfile.new(["solr_map", ".yml"])
      File.write(map.path, YAML.dump({ "game_id" => ["id"], "title" => ["title_display", "title_facet"], "notes" => ["notes_display"] }))

      calls = {}
      fake_solr = Object.new
      fake_solr.define_singleton_method(:add) do |documents, add_attributes:|
        calls[:documents] = documents
        calls[:add_attributes] = add_attributes
      end
      fake_solr.define_singleton_method(:commit) { calls[:committed] = true }

      RSolr.stub(:connect, fake_solr) do
        HarvestCSV.harvest(csv.path, map.path, "http://solr.example.test/solr/core")
      end

      assert_equal [{ "id" => "1", "title_display" => "Example", "title_facet" => "Example" }], calls[:documents]
      assert_equal({ commitWithin: 10 }, calls[:add_attributes])
      assert_equal true, calls[:committed]
    ensure
      map.close!
    end
  end

  private

  def with_tempfile(contents)
    file = Tempfile.new(["harvest_csv", ".csv"])
    file.write(contents)
    file.flush
    yield file
  ensure
    file.close!
  end
end
