# Zhuoyuan Hao (Larry Hao) — Research Website

Source for [hhh2210.github.io](https://hhh2210.github.io/), a Jekyll site that presents Zhuoyuan Hao's research, publications, and project work. The repository also publishes plain-text and JSON routes so the same public facts are available without parsing the visual site.

## Metadata contract

`_data/research.yml` is the canonical source for academic identity and core paper metadata: stable IDs, exact titles, authors, publication dates, venues, paper URLs, DOI/arXiv/OpenAlex records, and code repositories.

Pages connect to a canonical paper with `paper_key`. Their front matter owns page-specific presentation fields such as descriptions, topics, Markdown alternates, and software descriptions; it must not copy core paper fields from the registry.

The JSON files under `api/` are currently committed mirrors rather than generated files. `test/metadata_contract_test.rb` prevents their identity and paper fields from drifting from `_data/research.yml`. Long-form prose in pages, `llms-full.txt`, FAQ, glossary, and media material remains editorial content and is intentionally not rewritten by the contract test.

## Repository map

- `_data/research.yml` — canonical person and paper records.
- `_includes/meta.html` — HTML, Open Graph, Twitter, and Highwire citation metadata.
- `_includes/structured-data.html` — Schema.org JSON-LD generated from the canonical records.
- `papers/`, `projects/`, `publications.md` — human-readable research pages.
- `llms.txt`, `llms-full.txt`, `markdown/` — plain-text retrieval surfaces.
- `api/` — static JSON profile, project, paper, and endpoint records.
- `sitemap-ai.xml` — inventory of machine-readable routes; normal pages are handled by the generated `sitemap.xml`.
- `.github/workflows/` — site validation and post-publish IndexNow notification.

## Local verification

The commands use Ruby's standard library plus the Jekyll and plugins already required by `_config.yml`.

```bash
ruby test/metadata_contract_test.rb
jekyll doctor
jekyll build --strict_front_matter --destination /tmp/hhh2210-site
SITE_DIR=/tmp/hhh2210-site ruby test/metadata_contract_test.rb
```

The first test validates source metadata and sitemap coverage. The rendered-site pass parses every published JSON file and embedded JSON-LD block, then verifies that scholarly citation metadata matches `_data/research.yml`.

## Updating research metadata

1. Edit the canonical record in `_data/research.yml`.
2. Update the corresponding committed JSON mirror under `api/`.
3. Update prose only when the underlying evidence or intended wording changed.
4. Run both source and rendered-site verification commands above.

Do not add a second copy of a core paper field to page front matter. A failing metadata contract identifies the exact mirror or page that needs attention.

## Publishing behavior

GitHub Pages builds the `master` branch. Pull requests and pushes to `master` run the site CI before changes should be merged. The separate IndexNow workflow submits the affected public URLs after a `master` push; it does not change site content.

The machine-readable routes improve access to already-public, source-backed material. They do not establish or guarantee search ranking, model inclusion, answer citation, or any other discovery outcome. Crawler permissions are declared separately in `robots.txt`.

## License

See [LICENSE](LICENSE).
