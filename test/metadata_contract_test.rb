# frozen_string_literal: true

require "cgi/escape"
require "date"
require "json"
require "minitest/autorun"
require "rexml/document"
require "rexml/xpath"
require "uri"
require "yaml"

class MetadataContractTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)
  SITE_DIR = ENV["SITE_DIR"] && File.expand_path(ENV["SITE_DIR"], ROOT)
  RESEARCH = YAML.safe_load(
    File.read(File.join(ROOT, "_data/research.yml")),
    permitted_classes: [Date],
    aliases: false
  )
  CORE_PAPER_FRONT_MATTER = %w[
    paper_title
    paper_url
    paper_arxiv
    paper_repo
    paper_status
    paper_date_published
    paper_citation_date
    paper_venue
    paper_report_institution
    paper_report_number
    paper_arxiv_id
    paper_doi
    paper_doi_value
    paper_openalex
    paper_pdf_url
    paper_authors
  ].freeze
  def source_path(relative_path)
    File.join(ROOT, relative_path)
  end

  def read_json(relative_path, root: ROOT)
    JSON.parse(File.read(File.join(root, relative_path)))
  end

  def front_matter(path)
    match = File.read(path).match(/\A---\s*\n(.*?)\n---\s*(?:\n|\z)/m)
    return unless match

    YAML.safe_load(match[1], permitted_classes: [Date], aliases: false) || {}
  end

  def papers_by_key
    @papers_by_key ||= RESEARCH.fetch("papers").to_h { |paper| [paper.fetch("key"), paper] }
  end

  def author_names(api_record)
    api_record.fetch("authors").map { |author| author.is_a?(Hash) ? author.fetch("name") : author }
  end

  def test_research_registry_has_stable_identity_and_paper_records
    person = RESEARCH.fetch("person")
    %w[id name alternate_names url email affiliations same_as].each do |field|
      refute_empty person.fetch(field), "research.person.#{field} must be populated"
    end

    papers = RESEARCH.fetch("papers")
    keys = papers.map { |paper| paper.fetch("key") }
    ids = papers.map { |paper| paper.fetch("id") }
    urls = papers.map { |paper| paper.fetch("url") }
    assert_equal keys.uniq, keys, "paper keys must be unique"
    assert_equal ids.uniq, ids, "paper IDs must be unique"
    assert_equal urls.uniq, urls, "paper canonical URLs must be unique"

    papers.each do |paper|
      %w[
        id title url primary_url arxiv_id arxiv_url doi doi_url pdf_url
        abstract_html_url openalex_url date_published citation_date venue status
        repository_url authors same_as
      ].each do |field|
        refute_empty paper.fetch(field), "#{paper.fetch('key')}.#{field} must be populated"
      end
      assert_includes paper.fetch("authors"), person.fetch("name")
      expected_equivalents = %w[primary_url arxiv_url doi_url openalex_url].map { |field| paper.fetch(field) }
      assert_empty expected_equivalents - paper.fetch("same_as"), "#{paper.fetch('key')}.same_as is incomplete"
      assert_match(/\A\d{4}-\d{2}-\d{2}\z/, paper.fetch("date_published"))
    end
  end

  def test_pages_resolve_paper_key_without_shadowing_canonical_fields
    paper_pages = 0

    Dir.glob(File.join(ROOT, "**/*.md")).sort.each do |path|
      metadata = front_matter(path)
      next unless metadata

      relative_path = path.delete_prefix("#{ROOT}/")
      if %w[scholarly_article software_source_code].include?(metadata["schema"])
        refute_empty metadata["paper_key"], "#{relative_path} must declare paper_key"
      end
      next unless metadata.key?("paper_key")

      paper_pages += 1
      assert papers_by_key.key?(metadata.fetch("paper_key")), "unknown paper_key in #{relative_path}"
      duplicated_fields = CORE_PAPER_FRONT_MATTER & metadata.keys
      assert_empty duplicated_fields, "#{relative_path} shadows _data/research.yml: #{duplicated_fields.join(', ')}"
    end

    assert_operator paper_pages, :>, 0
  end

  def test_identity_json_mirrors_research_registry
    person = RESEARCH.fetch("person")
    profile = read_json("api/profile.json")
    index_owner = read_json("api/llm-index.json").fetch("owner")

    assert_equal person.fetch("id"), profile.fetch("id")
    assert_equal person.fetch("name"), profile.fetch("name")
    assert_equal person.fetch("name"), profile.fetch("full_name")
    assert_equal person.fetch("alternate_names"), profile.fetch("aliases")
    assert_equal person.fetch("alternate_names").first, profile.fetch("preferred_name")
    assert_equal person.fetch("url"), profile.fetch("website")
    assert_equal person.fetch("same_as"), profile.fetch("same_as")

    assert_equal person.fetch("id"), index_owner.fetch("id")
    assert_equal person.fetch("name"), index_owner.fetch("name")
    assert_equal person.fetch("alternate_names"), index_owner.fetch("aliases")
    assert_equal person.fetch("alternate_names").first, index_owner.fetch("preferred_name")

    featured_research = profile.fetch("featured_research")
    assert_equal papers_by_key.size, featured_research.size
    papers_by_key.each_value do |paper|
      featured = featured_research.find { |record| record.fetch("canonical_page") == paper.fetch("url") }
      refute_nil featured, "api/profile.json is missing #{paper.fetch('key')}"
      assert_equal paper.fetch("title"), featured.fetch("title")
      assert_equal paper.fetch("primary_url"), featured.fetch("paper")
      assert_equal paper.fetch("repository_url"), featured.fetch("code")
    end

    echoes = papers_by_key.fetch("echoes-as-anchors")
    featured_work = profile.fetch("featured_work")
    assert_equal echoes.fetch("title"), featured_work.fetch("title")
    assert_equal echoes.fetch("repository_url"), featured_work.fetch("github")
    assert_equal echoes.fetch("primary_url"), featured_work.fetch("openreview")
    assert_equal echoes.fetch("url"), featured_work.fetch("paper_page")
  end

  def test_site_config_keeps_canonical_identity_fields_in_the_research_registry
    person = RESEARCH.fetch("person")
    config = YAML.safe_load(
      File.read(source_path("_config.yml")),
      permitted_classes: [Date, Symbol],
      aliases: false
    )
    author = config.fetch("author")

    assert_equal person.fetch("alternate_names").first, config.fetch("name")
    assert_equal person.fetch("alternate_names").first, author.fetch("name")
    assert_equal person.fetch("email"), author.fetch("email")
    assert_empty %w[full_name affiliation same_as] & author.keys,
      "canonical identity fields belong in _data/research.yml"
  end

  def test_paper_and_project_json_mirror_research_registry
    projects = read_json("api/projects.json")

    papers_by_key.each do |key, paper|
      relative_path = "api/papers/#{key}.json"
      api_record = read_json(relative_path)
      project_record = projects.find { |project| project.fetch("name").downcase == key }

      refute_nil project_record, "api/projects.json is missing #{key}"
      assert_equal paper.fetch("title"), api_record.fetch("title")
      assert_equal paper.fetch("status"), api_record.fetch("status")
      assert_equal paper.fetch("date_published"), api_record["published"] || api_record.fetch("date_published")
      assert_equal paper.fetch("arxiv_url"), api_record.fetch("arxiv")
      assert_equal paper.fetch("doi_url"), api_record.fetch("doi")
      assert_equal paper.fetch("openalex_url"), api_record.fetch("openalex")
      assert_equal paper.fetch("repository_url"), api_record.fetch("github")
      assert_equal paper.fetch("authors"), author_names(api_record)
      assert_equal paper.fetch("primary_url"), api_record[key == "echoes-as-anchors" ? "openreview" : "arxiv"]
      canonical_page_field = paper.fetch("url").include?("/papers/") ? "paper_page" : "project_page"
      assert_equal paper.fetch("url"), api_record.fetch(canonical_page_field)

      assert_equal paper.fetch("title"), project_record.fetch("title")
      assert_equal paper.fetch("repository_url"), project_record.fetch("github")
      assert_equal paper.fetch("arxiv_url"), project_record.fetch("arxiv")
      page_field = paper.fetch("url").include?("/papers/") ? "paper_page" : "project_page"
      assert_equal paper.fetch("url"), project_record.fetch(page_field)
    end

    concepts = read_json("api/papers/echoes-concepts.json")
    echoes = papers_by_key.fetch("echoes-as-anchors")
    assert_equal echoes.fetch("title"), concepts.fetch("paper")
    assert_equal echoes.fetch("url"), concepts.fetch("paper_page")
  end

  def test_ai_sitemap_is_complete_unique_and_does_not_publish_stale_dates
    document = REXML::Document.new(File.read(source_path("sitemap-ai.xml")))
    namespace = { "sitemap" => "http://www.sitemaps.org/schemas/sitemap/0.9" }
    locations = REXML::XPath.match(document, "//sitemap:loc", namespace).map(&:text)
    last_modified = REXML::XPath.match(document, "//sitemap:lastmod", namespace)
    base_url = RESEARCH.fetch("person").fetch("url")
    source_files = ["llms.txt", "llms-full.txt"] +
      Dir.glob(source_path("api/**/*.json")).map { |path| path.delete_prefix("#{ROOT}/") } +
      Dir.glob(source_path("markdown/*.txt")).map { |path| path.delete_prefix("#{ROOT}/") }
    expected_locations = source_files.sort.map { |path| URI.join(base_url, path).to_s }
    index_locations = read_json("api/llm-index.json").fetch("machine_readable").filter_map do |record|
      url = record.fetch("url")
      url if url.start_with?(base_url)
    end

    assert_equal locations.uniq, locations, "sitemap-ai.xml contains duplicate URLs"
    assert_equal expected_locations, locations.sort
    assert_equal index_locations.uniq, index_locations, "api/llm-index.json contains duplicate local URLs"
    assert_equal expected_locations - [URI.join(base_url, "api/llm-index.json").to_s], index_locations.sort
    assert_empty last_modified, "omit lastmod unless it is generated from real content modification time"
  end

  if SITE_DIR
    def test_rendered_api_json_and_json_ld_are_valid
      source_api_files = Dir.glob(source_path("api/**/*.json")).map { |path| path.delete_prefix("#{ROOT}/") }.sort
      rendered_api_files = Dir.glob(File.join(SITE_DIR, "api/**/*.json")).map do |path|
        path.delete_prefix("#{SITE_DIR}/")
      end.sort
      assert_equal source_api_files, rendered_api_files
      rendered_api_files.each { |path| read_json(path, root: SITE_DIR) }

      json_ld_count = 0
      Dir.glob(File.join(SITE_DIR, "**/*.html")).sort.each do |path|
        File.read(path).scan(%r{<script type="application/ld\+json">\s*(.*?)\s*</script>}m).each do |match|
          JSON.parse(match.first)
          json_ld_count += 1
        end
      end
      assert_operator json_ld_count, :>, 0
    end

    def test_rendered_scholarly_metadata_comes_from_registry
      papers_by_key.each_value do |paper|
        page_path = URI.parse(paper.fetch("url")).path.delete_prefix("/")
        html = File.read(File.join(SITE_DIR, page_path, "index.html"))
        meta_values = lambda do |name|
          html.scan(/<meta name="#{Regexp.escape(name)}" content="([^"]*)">/).flatten.map do |value|
            CGI.unescapeHTML(value)
          end
        end

        assert_equal [paper.fetch("title")], meta_values.call("citation_title")
        assert_equal paper.fetch("authors"), meta_values.call("citation_author")
        assert_equal [paper.fetch("citation_date")], meta_values.call("citation_publication_date")
        assert_equal [paper.fetch("doi")], meta_values.call("citation_doi")
        assert_equal [paper.fetch("pdf_url")], meta_values.call("citation_pdf_url")

        json_ld = html.scan(%r{<script type="application/ld\+json">\s*(.*?)\s*</script>}m).map do |match|
          JSON.parse(match.first)
        end
        entities = json_ld.flat_map { |record| record["@graph"].is_a?(Array) ? record["@graph"] : [record] }
        scholarly_article = entities.find do |entity|
          entity["@id"] == paper.fetch("id") && entity["datePublished"]
        end
        refute_nil scholarly_article, "rendered page is missing #{paper.fetch('id')}"
        assert_equal paper.fetch("title"), scholarly_article.fetch("name")
        assert_equal paper.fetch("date_published"), scholarly_article.fetch("datePublished")
        assert_equal paper.fetch("repository_url"), scholarly_article.fetch("codeRepository")
        assert_equal paper.fetch("authors"), scholarly_article.fetch("author").map { |author| author.fetch("name") }
      end
    end
  end
end
